Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078D19BA0
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 16:29:22 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33b398f2ab8so465ab.0
        for <damon@lists.linux.dev>; Fri, 02 Jun 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685723361; x=1688315361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKBnoInz/hfKHAqZ0MziJwHfuM/u8WifJkdwiN8lH9c=;
        b=0dNapuj8fWuUrD05bvEuF/gQ9lzGpB/ebGiP3J8LGlV8M4twC1jeLAbcUYcoWGvx7S
         x4aGFL8zcJGqctUbBP6A0cqSxaH2NMN3uJ4d0wp/hOhkI0Tpca3LmSDAxW03IPfsaw4n
         a/J/xX4oBoF4gKt4jfdQHqS7jugAEk7IfxMPMNHxbeEfJosUtQNZDgPKZFIh9xIstDqI
         I1cy+vVbuUruH1Q17PRL7QReEqzaBggUOrFBe049n4OemV5eVd06t580FfSaadkBHfO3
         TftUHH5G0XSkWCCeQu+4QAz4PMmIQenCd7BcLFY10MS09IEW/ZSr3wIHFUW7FYi4ihFq
         OV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723361; x=1688315361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKBnoInz/hfKHAqZ0MziJwHfuM/u8WifJkdwiN8lH9c=;
        b=ldFKdPXW+PYlPT4D1MgdJSTn1yjtWzsV56L0VbKAeYHuIj7SFbFvIGmkAHWCnOZsNX
         lKmtPRP9oZ0UJLQc6x/vL7bxq37p+muJQ2AMWqXyz4qeYo15hWEVcw9dxHye0BgS5/vb
         ZYAXCxy9YgzgTxQQfzgwMGNKg1wITk1TlcboS6iTMDSSt3LNHw5JqTphV6K1V/2Irjhm
         vFOh+p0dx/Q01+p2FOLmBrYS/0lYhZvWEX73Xev7c10kuhlUCR4drTpJqyXOteCyC72h
         kF6uWoj3yyL/eTRvR9c4ILjgzAj3RqxsH/61tiAATh4FUUwfNnrYcK2VK5tRmEWGsmkM
         VFaw==
X-Gm-Message-State: AC+VfDye/xGfLzjQK0wrFC9SMXwD9qrJXNyRIRdQWmlJaou+/izsCCx9
	pANgjzOsWcOz10X4x6OVg6tvSP85YmxECdsj7fZP8Q==
X-Google-Smtp-Source: ACHHUZ7jmnT73huHmz9iN2tJAXJ8lyMfWvYoZhcBOrk6VnndDcSYSwNNGdjjayNalzZvjJ6g/Hkq/HRlJnfE7n6KHes=
X-Received: by 2002:a92:c543:0:b0:33a:e716:a768 with SMTP id
 a3-20020a92c543000000b0033ae716a768mr204439ilj.22.1685723361223; Fri, 02 Jun
 2023 09:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230602092949.545577-1-ryan.roberts@arm.com> <20230602092949.545577-4-ryan.roberts@arm.com>
In-Reply-To: <20230602092949.545577-4-ryan.roberts@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 2 Jun 2023 10:28:45 -0600
Message-ID: <CAOUHufZa7hzqC6tJMX1gm4kWmjB03f7qGhXUq1OLqfDQ789P5Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm/damon/ops-common: Refactor to use {pte|pmd}p_clear_young_notify()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 2, 2023 at 3:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> With the fix in place to atomically test and clear young on ptes and
> pmds, simplify the code to handle the clearing for both the primary mmu
> and the mmu notifier with a single API call.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Yu Zhao <yuzhao@google.com>
