Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE879D0
	for <damon@lists.linux.dev>; Mon, 15 May 2023 11:25:18 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso22323130a12.2
        for <damon@lists.linux.dev>; Mon, 15 May 2023 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684149916; x=1686741916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYw5o0HvEEWDxkyofYj3KGUxctwFLArsyHtXdfw7FXA=;
        b=jbbvynNqFDwn5QGIBqkxPLjOSvS9oQg0sxK8yIwEW1+QFpaNk5RVVAxyeKo8OlEX8y
         TWq0itO/EsZROeoya7JAVtTucCE9VuwFEDst6h2TgueFAsjiZ+nfPNq40EU4WTySbNhD
         NP4m1kFt4ktBIXCefxWIG/SDV8rBzF2S49Ah3k/0dRQVsY7xF88UiXf6z3qaQzQ9CbEu
         CsMgHcBG/rk9NtzxOY6zQcQ5caE8et0FgVHapn7BHz3Lif7Mh+P1mBfRjMM6eU19jfmi
         3nOCUihOFR05tuKO6bhuiZjWTfJqa140N/1xcCUsUU1WYhO1qQKSIyP9zdRY4uE1otZH
         0FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684149916; x=1686741916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYw5o0HvEEWDxkyofYj3KGUxctwFLArsyHtXdfw7FXA=;
        b=UHRLgV3MhnBNGi9QnYfEoXVlIq3avKS2llCGpbOJAY2CxvZ68yTozLLJVq83JQA6yr
         U/hMLEo5R3jPmPx2uJk3P8JUDiMsvc579XkKdZXCnIceQ2GqiG4mFYWAEwCT61306VUK
         Oa2V2tYxtWQ6V7dpFBg/6ZM5Nn/Fh/VQmoFAeZoxkBaGfLkObCKcTsLJd23gITbADPE/
         s9/MspWXbF9TL3Uwg1ZbzhaC8hNFlPrqc7HCYaEhTasHYA6kOh8VI3X1XW+F6Db+QHRa
         AO6pqr2BVHYAdLABqNX84az5xxK6HBhsH+URCHRX3j47nIYDmkTft0fMkpR+hZlzy7XP
         KzHQ==
X-Gm-Message-State: AC+VfDy22pzBNolceei5BFMOH96eo8ddYKzbuT1MZx+z67aZFwFEOkIh
	lgmZSlSVyyem45cznXPcazk=
X-Google-Smtp-Source: ACHHUZ4Qid7cgUwxhiv6jrJ7EnqBsE3iqwJImnN2vzCNgOHm4KFYH0qvM0L5MJTHJ6iYr10udidLow==
X-Received: by 2002:a17:906:db08:b0:94f:1c90:cb70 with SMTP id xj8-20020a170906db0800b0094f1c90cb70mr30936700ejb.66.1684149915837;
        Mon, 15 May 2023 04:25:15 -0700 (PDT)
Received: from localhost ([31.94.21.70])
        by smtp.gmail.com with ESMTPSA id h9-20020a170906584900b0094e597f0e4dsm9248259ejs.121.2023.05.15.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:25:15 -0700 (PDT)
Date: Mon, 15 May 2023 12:25:14 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	SeongJae Park <sj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Message-ID: <54ecd324-91ac-4fbc-8c47-46f12b2f5256@lucifer.local>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
 <db1b8b8f-c3ac-4dbb-8b15-125c0929856a@lucifer.local>
 <2d43731e-3a38-c96e-320e-6a0dc16f10e4@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d43731e-3a38-c96e-320e-6a0dc16f10e4@arm.com>

On Mon, May 15, 2023 at 09:29:16AM +0100, Ryan Roberts wrote:
> Hi Lorenzo,
>
> Thanks for the review - I appreciate it!
>
>
> On 13/05/2023 14:14, Lorenzo Stoakes wrote:
> > You've not cc'd the vmalloc reviewers, including the author of 3e9a9e256b1e
> > whose patch you purport to fix. Please remember to run get_maintainers.pl
> > on all files you patch and cc them at least on relevant patches.
> >
> > Have added Christoph + Uladzislau as cc.
>
> I did run get_maintainers.pl, but it gave me 82 names. I assumed I wouldn't be
> making any friends by CCing everyone, so tried to choose what I thought was a
> sensible base. I guess I didn't quite get it right. Sorry about that. Thanks for
> noticing and adding the right people.

Right you mean across the whole of the patch set? Different people have
different approaches as to how to cc patch sets as a whole, but it's not
optional to include maintainers and reviewers on patches, so you should at least
cc- them on individual patches.

It's ok, it's really easy to mess this up, I have managed every variant of doing
this the wrong way myself... :)

>
> >
> > You'll definitely want an ack from Christoph on this!
> >
> > On Thu, May 11, 2023 at 02:21:09PM +0100, Ryan Roberts wrote:
> >> It is bad practice to directly set pte entries within a pte table.
> >> Instead all modifications must go through arch-provided helpers such as
> >> set_pte_at() to give the arch code visibility and allow it to validate
> >> (and potentially modify) the operation.
> >
> > This does make sense, and I see for example in xtensa that an arch-specific
> > instruction is issued under certain circumstances so I do suspect we should
> > do this.
>
> arm64 provides another example, where barriers are required to ensure the page
> table walker sees the new pte and no fault is raised. See
> arch/arm64/include/asm/pgtable.h:set_pte() (which is called by its
> implementation of set_pte_at()).

Ack, yeah I do think your patch is correct.

>
> >
> > As for validation, the function never indicates an error, so only in the
> > sense that a WARN_ON() could _in theory_ trigger is it being
> > validated. This might be quite a nitty point :) as set_pte_at() has no
> > means of indicating an error. But maybe to be pedantic 'check' rather than
> > 'validate'?
>
> I'm sorry, I'm not sure what you are asking here? set_pte_at() forms part of the
> contract with he arch code and is defined never to return an error. Some
> implementations might have code enabled in debug configs to detect incorrect
> usage and emit warnings (see arm64's implementation).

I'm saying that 'validate' implies to me that you assess whether the value is
correct and behave differently accordingly. It's something of a pedantic point,
but perhaps 'check' is better here.

>
> >
> >>
> >> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> >
> > Not sure if this is really 'fixing' anything, I mean ostensibly, but not
> > sure if the tag is relevant here, that is more so for a bug being
> > introduced, and unless an issue has arisen not sure if it's
> > appropriate. But this might be a nit, again!
>
> Well I'm happy to remove it if that's the concensus. But I do believe there is a
> real bug here. At least on arm64, the barriers are needed to prevent a race with
> the page table walker. That said, the only place in the tree I can see
> vmap_pfn() used, is in the i915 driver, which I guess has never been used on an
> arm64 platform.

Yeah, again this might be a little too nitty! And I totally understand where
you're coming from, I do agree this is appears to be an issue and your solution
is right, it just feels less like an obvious 'bug' and more of an oversight. But
I am being pedantic, and am not overly worried if you retain it :)

>
> >
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/vmalloc.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index 9683573f1225..d8d2fe797c55 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -2899,10 +2899,13 @@ struct vmap_pfn_data {
> >>  static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
> >>  {
> >>  	struct vmap_pfn_data *data = private;
> >> +	pte_t ptent;
> >>
> >>  	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
> >>  		return -EINVAL;
> >> -	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> >> +
> >> +	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> >> +	set_pte_at(&init_mm, addr, pte, ptent);>
> > While we're refactoring, it'd be nice to stash data->pfns[data->idx] into a
> > local pfn variable.
>
> OK, I'll do this for v2.

Thanks!

>
> Thanks,
> Ryan
>
>
> >
> >>  	return 0;
> >>  }
> >>
> >> --
> >> 2.25.1
> >>
>

Sorry to get into the weeds here a bit, overall I think this patch is fine, I
would like Christoph to take a look given it's his code however.
