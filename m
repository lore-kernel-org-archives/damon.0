Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225633310
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 17:36:16 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so7655ab.0
        for <damon@lists.linux.dev>; Fri, 02 Jun 2023 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685727376; x=1688319376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYGuxy8Ej8tRmw8Uag/5H01fuHpZsdaCh2dA+H02kPM=;
        b=AiObH6k1yxEvPCx51OIA8EV79fxDTSyeBg01wdrmxpGcD6UdUsMYOJwf/c1hToEGp5
         A9G+k6Wo8HljKcNncggTq9A+iEMYRTwo5i7E6l6f632glXN9vPAFmTI79exvZuaynYDK
         bHyfpIBzFsV+rTeMQqtycEU01a6xAzUg4SZ8IHuVkBV650P7H190xDpMbgqcZbUeQFa4
         qHkWSrLYV1CaZ4ehzMflooIUi8EQKCfcJn1kIxUEYhIhDGtnSiG6+s9uqnFTjJ8GFe7t
         /lDwet166VDDHCfma+oh0a26VEDHNnYP8zmPTljMn8h+37iC2EP9ZsMcOFpem893YACv
         p5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685727376; x=1688319376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYGuxy8Ej8tRmw8Uag/5H01fuHpZsdaCh2dA+H02kPM=;
        b=UVf5T/GO/IyCn2FW5XhRvtzO6UwSFMFllqtrLV/9VYYQSN8zBagFba3xSvGDyqnK8Y
         8PZ9jeCLXuZMV6ihHM9MdssESfIP9ArZKUcMvRlBy8dVnBjB2UwkWGBwSVDxgBMs5434
         y7u6EMiSmrhD7MNUoGijfEq6qd1xuut3l1zElHmasI+ig87WvRFttCR/T0ZIxJX7Q9pi
         2fn5+6DoEiuz8MlvxkAJSQrSQb1efKBVbxp8M6if1cb8GQDrehOKV0Nui9y7zNrsTXa2
         wBMAFpKuHEqCbla3e+CP20qtYVePZQP4SnDUcZeBq/PVm6bu4wgisth0xupQeppNAB5M
         oeUw==
X-Gm-Message-State: AC+VfDwofc1Yh17cYlWX+NwusP2p3m2gYnwh0eZYJ442vFhgPAuIcoS0
	1kjxg2zeNko9A28IBPL+SUV1eFm41AlOjd9aJyKbLQ==
X-Google-Smtp-Source: ACHHUZ6wj7whRMGkFLe9wDNGh8O3OzAA6um6O9lWia/t8YK+4adlmlDW6jCDZkxTijAzhN1cAzOrQ9c3l6HGhUEm6Fw=
X-Received: by 2002:a05:6e02:164a:b0:33c:c3ed:889c with SMTP id
 v10-20020a056e02164a00b0033cc3ed889cmr270037ilu.12.1685727375853; Fri, 02 Jun
 2023 10:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230602092949.545577-1-ryan.roberts@arm.com> <20230602092949.545577-3-ryan.roberts@arm.com>
 <CAOUHufb5R_+eMxM28WWxXubPzUO4+c_1UHoXVAcWsKEyG1ndAQ@mail.gmail.com> <640f81aa-035e-9f42-c848-096e4c9e014c@arm.com>
In-Reply-To: <640f81aa-035e-9f42-c848-096e4c9e014c@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 2 Jun 2023 11:35:39 -0600
Message-ID: <CAOUHufakZjOK445jkMorPsqkdZuwKGxmym4+0p=s2NtB1GtbBQ@mail.gmail.com>
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

On Fri, Jun 2, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 02/06/2023 17:35, Yu Zhao wrote:
> > On Fri, Jun 2, 2023 at 3:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> It is racy to non-atomically read a pte, then clear the young bit, the=
n
> >> write it back as this could discard dirty information. Further, it is
> >> bad practice to directly set a pte entry within a table. Instead
> >> clearing young must go through the arch-provided helper,
> >> ptep_test_and_clear_young() to ensure it is modified atomically and to
> >> give the arch code visibility and allow it to check (and potentially
> >> modify) the operation.
> >>
> >> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual m=
emory address spaces").
> >
> > Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
> > deemed unnecessary?
>
> It was overlooked - incompetance strikes again! I was intending to cc the=
 whole
> series. What's the best way to fix this? Can I just add stable in cc on r=
eply to
> the cover letter or will I have to resend the lot?

Resending the whole series would be more reliable for the process (and
easier for Andrew). You might want to include a few new
reviewed/acked-bys anyway (I just acked the next patch).
