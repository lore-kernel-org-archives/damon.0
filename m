Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA973B9DAB
	for <damon@lists.linux.dev>; Mon, 18 May 2026 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779082754; cv=pass; b=BiuOWPG0vbn+Q4q30DtnYTrPFwt1SjBfusG/09Es73rRn18abnS+2rK9/yAhMvSk5sziNZT8KsQjPdwNiM8Ri7wLUofY1peZS2jYv5S5q9ePdOJ2aWT3oyXjG/xR76bPZY6MmuFi3NG3k6Rw9gyG3jql8hSim5WQwmi2s9WozT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779082754; c=relaxed/simple;
	bh=ZU9zcwa/1oA+08JxSkZueqLN2CpJd+9cjTLHgOB8s8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSiMNWRxlBZOwHoaILVss1VE3K6kQaENJlm2bs0KwJsNaMv4y4LvEeIUUJG4z8cUdewVU2u6lrFJsEuDLrlnBDg1hpFVq8ejdW8HPe7a7gQMIi1VaVjQPOo5HdncutP7cABMILH9S+0VgvxbLFPDZ+Gvs85nqxwpkwnDKKVW/Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObUkcW3p; arc=pass smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObUkcW3p"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2c156c4a9efso2168641eec.1
        for <damon@lists.linux.dev>; Sun, 17 May 2026 22:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779082744; cv=none;
        d=google.com; s=arc-20240605;
        b=DrfBhCs30BHplitYPsUSx8BOsESNfEVTmKqKO4PJzyeIgWPUWoPUGGgJRWdnHRLZ1S
         BokRG/LaLDSc1JMjQdY/7ABIrxgqY9Ys7oszArleMZtR/EFoftt4k8ZQzVRvycqbt5e6
         GRqUOnPlUMw4gTPYrREa/oxIm2q+WwOli42m7QbzsbY3t6E1q2/Wv2kRrBwAlN+METBf
         0nnBKohBMwj1PQchKF9K6Zv/UjiSWFY7bM0PWESG9SqqomVNqLhWuCxv0E4VwlioITU/
         gJwu3ktQ7pnWs8oWu5k0Sn8IO6ES2TgtfRdDWw4zPYaFOWWBCED2xcTNL1HIo1HpqP+Q
         Apyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLIcqWTVpJE5E6ocMJoFGIXQYdlOWCw+6fTR5Kv3lQU=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=OPJTjX5nvHCqWxqRsTbe4M5CJpZ/CGxwDZpjwFrVf3z5sv8iWL/PGv5PcG/3Bdqt3k
         3OlSaKAn1K7EMfUhlNTeI/fhOSMBrsdznl6eEPQ21oRhvvMrCd3D78mnlOZCtNZLY9zz
         B5AJLW3RU/igRrTSkJ6C2RoELofGX90IoMCYDLyi1X9CpvWtIB2jLGg9U1dJopl+oisE
         KbjTFQR0IGDDu16oi0SniGDQDThbgHVvBGkFw627S1v7SmUQvNbvnJGDKZpQE3NrWcCw
         Q57Clo4ityMgga4PCQ481IvPC9EuTMwMcMZzNFseaFGct695D45ZZAa8fsarOdWdEUHr
         vf5w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779082744; x=1779687544; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLIcqWTVpJE5E6ocMJoFGIXQYdlOWCw+6fTR5Kv3lQU=;
        b=ObUkcW3pYKiMuxPnnIGfXa334FUD52k0f1IQXDUEnlv/sEuD48dkV1LVLCN9T92Z7s
         OLzo53g7ibn23O3lMbAlmmI+xF3BZ63iipR3O0OUc16s5l0Jz6F9lkbRyLDQozNeQXMk
         fTCbsAPYkcohH4DEY28Q5N9NKq+sNCLhBdYdpfHOuhNT6ccqJ80slGBiNm3APuV4DUIw
         6cGjmRQRUaCJEzEmp4VjrB6PjAY4G0f29LRUc2TCAd4/zZh9Dl81m6+hbc7Q44IOCuHl
         9LLfAidyoYqmph60tDH6m9OFC+w0u9BbE4d7dUrJkPpm5kxucTt+ntl6H6JPgtZheF05
         mwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779082744; x=1779687544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YLIcqWTVpJE5E6ocMJoFGIXQYdlOWCw+6fTR5Kv3lQU=;
        b=BPx8C0HVHe+ceam56GfI0qUUJSKYveLKkxgA7LOw4Np7reAWC7P2gEE6GsAj8Y0xyy
         h+7jNR6h7bBTKMQJ7DuvkBygLHPHXnTP4h/JXj/M/rgxtGeg5dwgXdZq+fQoCZg9oZIX
         ho11W/GlsQv56vXr/u3hi9ja5bP52X5uUNG/nuB8b++fpoPnH64rNtv6IP0VZ4i+phKS
         NNCCs8LJxwBoP13xqeeSHk3QKgDgevfn7N6AvmwCnkTOCjNJjGCBAI8kQo27Bi7AnbW6
         rkznls1natS3HGVMlH5it0kiiCa/TY1VS052ee5Lk8dpf/XwSm3xoJ8g2FPwT8Mo6kAY
         CpNw==
X-Gm-Message-State: AOJu0YxwacoQH3tCsRRbfO+xZH1f9xOoMDlqRTZhyWW8skaEfd5RKpvC
	H5JZxadHMBDFXdaMc22Fx04E/5W5IQ4yTTZe9ieDX0Vtj283pyNZ4vcZv8tWQ/6iLgflkFWAfAX
	GX0vLLbVfky5VjhrJeJbwENl0TxZAhw==
X-Gm-Gg: Acq92OFG5vKHYVy1VI/Xm5+zkJh3bJgPq2gM/rE3WGxpMLm6sEjFxKVrWgtSE0ywXEA
	7iUMv7ZfOSHIizA18Tpp3wl9VzBdO9vo+h8pqG6EsGSgLvJ/juMlS92iOfxWBABkar4t2pRAwaM
	dIrRnP4DcX5kSmaAnQw9hTedjAHLa6iHocOUjpG5cX2v1mw+JrJssKafGa28Hjme+rs7oO4ie4S
	/u0Cgii/sapOTTHNuiJwzJ0nKge0snzxzd8g2BzU64MaoiQNHHhsPGAx+NL7zlh8oErm46vVMob
	AL7AON+BnaIBCtQLwA==
X-Received: by 2002:a05:7022:f9a:b0:132:5d31:dcb4 with SMTP id
 a92af1059eb24-1350483cd3bmr5446081c88.23.1779082744288; Sun, 17 May 2026
 22:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260516210357.2247-5-ravis.opensrc@gmail.com> <20260517233756.89097-1-sj@kernel.org>
In-Reply-To: <20260517233756.89097-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sun, 17 May 2026 22:38:51 -0700
X-Gm-Features: AVHnY4K2ub7Wht5Qs4RyrHgIQ9aprUqnUTmA2ZoG_aUhnEoirB9aJCACF4FE6fU
Message-ID: <CALa+Y17nudor22aJvakfos3UegPgEG1M8N7cJPAxWX0Ca=MvfA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] mm/damon/paddr: skip free pageblocks in migration walk
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 4:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sat, 16 May 2026 14:03:56 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > damon_pa_migrate() walks every PFN in a region linearly, calling
> > damon_get_folio() for each one.  On sparse physical address spaces
> > (e.g., CXL-attached memory), a single DAMON region can span hundreds
> > of gigabytes where most memory is free and sitting in the buddy
> > allocator.  Most page lookups are fruitless and dominate kdamond
> > tick time.
>
> On sparse address spaces, the problem would be large DAMON regions of off=
lined
> memory.  The large DAMON regions that nearly all freed memory is another
> problem that doesn't require the sparse address spaces.  If I'm not wrong=
, the
> above paragraph could better clarified in my opinion.
>
> >
> > Check at pageblock boundaries (2MB on x86_64) whether the block is
> > entirely free.  If the first page of a pageblock is a buddy page at
> > pageblock_order or higher, the entire block is free and can be
> > skipped.
> > Similarly skip pageblocks where pfn_to_online_page() returns
> > NULL.
> >
> > This reduces the iteration from O(region_sz / PAGE_SIZE) to
> > O(region_sz / pageblock_sz) + O(populated_pages).
> >
> > buddy_order_unsafe() is used without zone->lock.  A transient false
> > positive (block becomes non-free between the PageBuddy and order
> > checks) costs at most one tick of missed candidates on that block;
> > the next tick re-scans.  No correctness consequence as DAMON walks
> > are best-effort.
>
> I was initially thinking this is a good and reasonable optimization appro=
ach.
> But on the second thought I get below questions.
>
> For large offlined memory space problem, couldn't we simply tune DAMON's
> monitoring regions boundary to ignore the holes?
>
> For large free memory area, is it reasonable to assume such situations?  =
In
> production, users will try to utilize as much memory of the system as pos=
sible.
> Then, wouldn't there be such problematically large free memory area?
>
> Could you please enlighten me?
>

Hi SJ,

You're right on the first point.  For static offlined memory
holes (memory hotplug gaps, partial socket population, etc.) the
right answer is configuring the monitoring region boundaries to
exclude them upfront, not making the walk skip them at runtime.
The changelog is clearer if I narrow the patch to the free-but-
online case.

On the free-online case: I agree large free memory areas are
not the steady state on a fully-utilized system.  The cases I
had in mind are more limited:

   - A workload using a small part of a much larger range, with
      the rest left as headroom (e.g. 64 GB used of a 512 GB
      range).

  - Shared tiers where workloads are allocated and freed on their own
    timelines.  Any single piece of free memory doesn't last
    long, but on a busy system there's typically a meaningful
    free fraction in the range at any point -- especially on a
    slower tier, where workloads prefer faster memory first
    when it's available.

The patch as written is a narrow optimization for those cases:
the pageblock-aligned check is one extra read per
pageblock_nr_pages PFNs (about 1 per 512 on x86_64), so it's
effectively a no-op when the region is fully populated.

If you don't see those workloads as warranting the change, I'm
happy to drop the patch.  If the framing is the issue more than
the change itself, I can respin a v2 with:

  - the changelog narrowed to the free-but-online case (no
    offlined-memory framing);
  - any suggestions from you on sashiko's review comments.

Thanks,
Ravi

> I will hold digging deep until this high level questions are answered.
>
>
> Thanks,
> SJ
>
> [...]
