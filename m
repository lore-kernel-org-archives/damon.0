Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874D17C9
	for <damon@lists.linux.dev>; Fri, 26 May 2023 02:03:14 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-33a8f766b64so45495ab.1
        for <damon@lists.linux.dev>; Thu, 25 May 2023 19:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685066594; x=1687658594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNtWvPa28u8wZV0f4gpjr4fry1u8z+TX9d18m7U9c/Y=;
        b=qWdwWqkCCTrSBfiqEXFlPREbqH9nZcRKo8eUTletLcLKGRfEd8BVHPYe6UHX/gvwE5
         miVrAiLJEcZdAICpaldRssz9r8HdxlCrAh114QYxjrmTn6IGRCfhb2Hv5J1Oeu3fy/SF
         7z+tw19d0oZdlyEH3kaTpOpEgoJ0jVXi+sl+5uhTsfr+i4f0gNx2IpMn7DsXa/eDyW7+
         lPNp09CxaZW14hXdDcH0MVYt5kN5tKRPhSn4XJ0KH+VLs+kG7DmmiC7igkEq+TrVl+q9
         qGRSI8gpv+Tfvu4yQyCeG60+FxbGNCF6cKkFvVJwNnynFUyHvVJUccJXZLSARhxIY6Af
         EPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685066594; x=1687658594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNtWvPa28u8wZV0f4gpjr4fry1u8z+TX9d18m7U9c/Y=;
        b=g0jv07F0jDoMKYfwrz07SS+J32wr3NwgMFhLYcFuFDGgOHZO7PTYVuDlG0wP6TRJaX
         tCEy0S24eQEqwbf7TW1LOa8+vj1OfIa6kOcFh/ZLw1yyrwRsljTGqi+zu/h33gMAGgd4
         0e45Kh6rFo+qzBQY8YpFZxcLdfQhGyH+faVfJ5GgeJTHioSY01IoCNzLLMPXvphe0fxO
         kZfL39DLsxPeJTRKCDP5c61pJe7IS0gU6YlEMkXoIbKm5R94wncpvI4k6Q81Wj92sDTl
         pTH99GHtct5WRTDmxBfsjyoQDn/L0dLKreMLpJe+wPCYYfYhZ+4SJ4Zx6EsLNW27NVNs
         qYtw==
X-Gm-Message-State: AC+VfDwjfGvNUhLSiyu4ag3Hs1S8keq4F/EtwQBkZD7MHZEWTO96bIRk
	N2pHea6o2Nkw5sPm4L4Y9+tyNDyhSCMnm9hFjASqQA==
X-Google-Smtp-Source: ACHHUZ4iI2JJ36IHzsm7dTn9A+Vj+4OycDbPHRLJ+FJ28mIjDg1G3+RBJ+IHC1KZvYl8wi08Yr+oSlfn4P76WrDoK0A=
X-Received: by 2002:a05:6e02:1c2e:b0:33a:e716:a76c with SMTP id
 m14-20020a056e021c2e00b0033ae716a76cmr399ilh.26.1685066593951; Thu, 25 May
 2023 19:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-5-ryan.roberts@arm.com> <CAOUHufZaiTCxk4M4w5GaA-+5FoMnHZt+fzoU=cYCA1Ldk7CVEQ@mail.gmail.com>
 <692e9e7e-ee00-368b-6a31-60a895f7011c@arm.com>
In-Reply-To: <692e9e7e-ee00-368b-6a31-60a895f7011c@arm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 25 May 2023 20:02:37 -0600
Message-ID: <CAOUHufZDYB_9QBau+9w-ZQWjFTQpnMf-i-jJn-T7=nFizYGDhw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 3:12=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 18/05/2023 20:28, Yu Zhao wrote:
> > On Thu, May 18, 2023 at 5:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> There are many call sites that directly dereference a pte_t pointer.
> >> This makes it very difficult to properly encapsulate a page table in t=
he
> >> arch code without having to allocate shadow page tables. ptep_deref()
> >> aims to solve this by replacing all direct dereferences with a call to
> >> this function.
> >>
> >> The default implementation continues to just dereference the pointer
> >> (*ptep), so generated code should be exactly the same. However, it is
> >> possible for the architecture to override the default with their own
> >> implementation, that can (e.g.) hide certain bits from the core code, =
or
> >> determine young/dirty status by mixing in state from another source.
> >>
> >> While ptep_get() and ptep_get_lockless() already exist, these are
> >> implemented as atomic accesses (e.g. READ_ONCE() in the default case).
> >> So rather than using ptep_get() and risking performance regressions,
> >> introduce an new variant.
> >
> > We should reuse ptep_get():
> > 1. I don't think READ_ONCE() can cause measurable regressions in this c=
ase.
> > 2. It's technically wrong without it.
>
> Can you clarify what you mean by technically wrong? Are you saying that t=
he
> current code that does direct dereferencing is buggy?

Sorry for not being clear.

I think we can agree that *ptep is volatile. Not being treated as such
seems a bad idea to me. I don't think it'd cause any real problems --
most warnings KCSAN reported didn't either, but we fixed them anyway.
So should we fix this case as well while we are at it.

> I previously convinced myself that the potential for the compiler generat=
ing
> multiple loads was safe because the code in question is under the PTL so =
there
> are no concurrent stores. And we shouldn't see any tearing for the same r=
eason.
>
> That said, if there is concensus that we can just use ptep_get() (=3D=3D
> READ_ONCE()) everywhere, then I agree that would be cleaner. Does anyone =
object?

(No objection to NOT using it either. Just a recommendation, since
it's already there.)
