Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E17332E1
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 16:35:45 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so114325ab.1
        for <damon@lists.linux.dev>; Fri, 02 Jun 2023 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685723744; x=1688315744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL/RdfyvK4VHp5q8idUxK6LQ2FtGlS/ZCzpuZxH0Kr4=;
        b=U0K2SertVzjMjsq1mX8Q/Agt5nHLaEwoFNNH8N1Wlm8M0uFXbdDKASjMkLx/xaBuVG
         6IZ/XqhNtha76hmPs6PyclkP/DjtIULydrKkfEui4e3FarIvZyiU4mTjtvI+sDCEDA7p
         HC9FsVW7pusUaXJqes+HN0omNgRliN7khyr/fCFdHUkzynQTiv5dFuPQSDi7zkUaWKvy
         CA/QJW/xjLroJy3+My4d/5yesIP6UL+1FugGpUghsaBWHP2/Wz4KeztPNw5p1cYzzQjN
         TwOVG/bWKKUM2/4qTk90r1qPZuaed838+byuz/NehufvS0ipckD4U7et6gsJAcUD0SGw
         Aqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723744; x=1688315744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL/RdfyvK4VHp5q8idUxK6LQ2FtGlS/ZCzpuZxH0Kr4=;
        b=dlvLB2p5N3ch9ZLCSgZqt1IbQz3DSM3GhuXSod5OYzw7awhFY0OZiqMKbs/JYy5OL3
         OnYw0wJyUbrW/8TTMQV1pOZ/IfyIsm6JO5YRjlqfet/PwTstYqW+LL6U8z1DFDS97dtd
         xBuv3D+EdFXqMAo8g0FBKViQLhD01S7HJ70Aq9vMYYa/iOSzua4rSra8V24l5bGVsJ/t
         W/QmQDLOHjykvbOjW0C+2pFijHeJOVRymEgQkrqA7z8aTuaGfsh+YxtUBq+7DIqSEoM0
         TXCsc4MdQG3WiSFzhfkR2nkAnKw9nD8QkvhhJ/MfbKCgSqYzkRiCqypTnOwp9ywn0cpR
         gVXQ==
X-Gm-Message-State: AC+VfDxjzuE3CoV1KCa44m0xI9EsG1XmleyelBM5bHGrWNpUkemCgZW1
	aiQbdjyM2kV6CE/ahN8/fJ+o3nfoePxu52qKwPqjwg==
X-Google-Smtp-Source: ACHHUZ7ERgLN87OyVJ5v5qBuR+nHPPKkYRfhwnOpN7C6Yk5dRXLnWBC8tclNySFapi7wnkNriSpvL6a7GG5gbcJ1rhM=
X-Received: by 2002:a05:6e02:1886:b0:33a:e716:a76f with SMTP id
 o6-20020a056e02188600b0033ae716a76fmr197727ilu.29.1685723744342; Fri, 02 Jun
 2023 09:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230602092949.545577-1-ryan.roberts@arm.com> <20230602092949.545577-3-ryan.roberts@arm.com>
In-Reply-To: <20230602092949.545577-3-ryan.roberts@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 2 Jun 2023 10:35:08 -0600
Message-ID: <CAOUHufb5R_+eMxM28WWxXubPzUO4+c_1UHoXVAcWsKEyG1ndAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/damon/ops-common: atomically test and clear
 young on ptes and pmds
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
> It is racy to non-atomically read a pte, then clear the young bit, then
> write it back as this could discard dirty information. Further, it is
> bad practice to directly set a pte entry within a table. Instead
> clearing young must go through the arch-provided helper,
> ptep_test_and_clear_young() to ensure it is modified atomically and to
> give the arch code visibility and allow it to check (and potentially
> modify) the operation.
>
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces").

Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
deemed unnecessary?

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
