Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066F20E01F
	for <damon@lists.linux.dev>; Fri, 13 Jun 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833197; cv=none; b=Xcn7vmXVQDi8d5v/qa9ZZaEZpHdo7yrdX/U95YqFj3BFaLVQnCRQp9E/wZsFT5c4gYSVl0xQr58IPBjMFJbDdawWf2vS82Job/ngxrJu/nlSYPCsfiTseuqHMp98VaWeM1uGmQ7awAoZczlBWzmoxR4Y55wr/axN0DJYnyD/Gx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833197; c=relaxed/simple;
	bh=qy48ViaN3if55ls8Ik4eE788CPNqNwEPM2Qlx4wnVvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6JxLGh8vh7e9CJDNRjxeAdpBfYF5v9i+FYxzybiqwLpksFogD5ZjRUwSK2aZ6RX9W0Msu8phCIYYHEARMS464oUIDzuoWIhoNH6aHzC+cSGyMB+7a15+EdFn/x2ul9rndOHvC164YRL+Zm1KMG1PoonMTWGr9IQgakVLzmSGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+NOHebf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+NOHebf"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade5b8aab41so485852366b.0
        for <damon@lists.linux.dev>; Fri, 13 Jun 2025 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749833194; x=1750437994; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8b+XF1R6IDkuZBmPOk+AjM7WkGgjUBKP1V8hx4ecgO8=;
        b=l+NOHebf2oORHMMCVdrdH8z20KwmpAR5VJHrLCGDclvlKPl6vOTggkhU45O59xVreZ
         FFiQF0GyDMPba4XolQXNevyqXTkUiH5GWxKmBspM2jexUsa6K2bol3gpUfyNzZZFQq6V
         BVQXiEl+nwDVT9ZhQWrVYvm53g2h9Z4A+hJmpKgEq9m7lUtiJZci+3jP8KCNmBTNZYfl
         CKnVgWMCUT7uZbeQGtjoUU3SrR+5Q06pbLcSl4tRlFqZijKAG4AHge0eqLnLx0DqIyVm
         0bGiSyWpXO+MUY46DgDDdFXGVp4QBJtlk/Bpy4B85IaENuE0yRuRjZSUW4XprZQ5y9tK
         xoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833194; x=1750437994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8b+XF1R6IDkuZBmPOk+AjM7WkGgjUBKP1V8hx4ecgO8=;
        b=SGwme1kTLJThcqERo7+kopP/ujEU9VIiDvs5cbuXtbMRjfQ1lJ6UlBymUyxvLgwxRg
         nu18MXvUsAvI3+33dMpA3DXpqm+yOSZK10PAwRkIUwwij7igY0E9NLd4NYe1Jc/kCbyq
         gQGuEgb+pxj5NcR+RO06yxj9017pp2fA0tFzNbtczU+8Vc/khPANHEiYDVQJ68PfYxcn
         5ik4lqNPXv7tpXVZ3JdDCSm39daqt3vpv4PJKjguY4FYRQs3WqU61ZrrefntgAOIVyvJ
         IoRD1fvH0td5OFVfNZhHMP7HMVEJFcXNYHvRAekbdkRhtp10amLs7lgdeB4UJ0ttpRPY
         +MJw==
X-Forwarded-Encrypted: i=1; AJvYcCUVCiDG1N63x0rnChxOphUBJWxjB/I6o6TH1bPt2oC+ckfAbZTn5FmpGHkjCR09zzXHKGxK6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMtgXdJPgzssgIuvjyypn0YsHjm0ZiFR+vVV5uYNEQ5NXTg5NF
	bF12zCP+iJZZr6w1R18TGOrWbTd8QHOJlxumWO2d0klsQm2zidRuaqfaApTrgr/5Nj+6jQ3p2cM
	xKs/4eIurXvRfVQle0aiux3lAdmYXMcU=
X-Gm-Gg: ASbGncsCHBUesqg0iFUGLtZlGXXhOdOgkHsJ9vrB+seg9PWQYgZr+aKfXYACML6YT70
	ttv7HlwnBXAM8FtIiLgY/T4Teh0p31ui9UXwxp549oC8P4t7JVVj0r5mkdDi/ZyMrGvwM8qdoFD
	A2bcbX0HtFVSmwRBR6j4GsvSqmAclvG5rJAdGQ89IavUAPg/Rn8ydhWDQPMc79fyII0zDJMeMAQ
	8CA
X-Google-Smtp-Source: AGHT+IFAM+0ARMBkOl378yE7TD1p2iruVPP2VsDOQczbz9maxLgWC1Hy5JyiV73B37TmNy5naByi7YIX04Dwzauu6Js=
X-Received: by 2002:a17:907:971e:b0:ade:32fa:739e with SMTP id
 a640c23a62f3a-adec54dac66mr411183266b.2.1749833194107; Fri, 13 Jun 2025
 09:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612181330.31236-1-bijan311@gmail.com> <20250613152517.225529-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20250613152517.225529-1-joshua.hahnjy@gmail.com>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Fri, 13 Jun 2025 11:46:22 -0500
X-Gm-Features: AX0GCFsgz60G6jm7BUq-axwbbcXxdq8WAFNMq5rp79wrCHhDW3-XBuJijPYHKiw
Message-ID: <CAMvvPS4COqinefth9rEB4etJF2erjQa3xfcOGQMtZ-LCUQnwFw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: Add DAMOS action to interleave data
 across nodes
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj@kernel.org, akpm@linux-foundation.org, 
	corbet@lwn.net, david@redhat.com, ziy@nvidia.com, matthew.brost@intel.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, bijantabatab@micron.com, 
	venkataravis@micron.com, emirakhur@micron.com, ajayjoshi@micron.com, 
	vtavarespetr@micron.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Fri, Jun 13, 2025 at 10:25=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> On Thu, 12 Jun 2025 13:13:26 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > A recent patch set automatically set the interleave weight for each nod=
e
> > according to the node's maximum bandwidth [1]. In another thread, the p=
atch
> > set's author, Joshua Hahn, wondered if/how these weights should be chan=
ged
> > if the bandwidth utilization of the system changes [2].
>
> Hi Bijan,
>
> Thank you for this patchset, and thank you for finding interest in my
> question!
>
> > This patch set adds the mechanism for dynamically changing how applicat=
ion
> > data is interleaved across nodes while leaving the policy of what the
> > interleave weights should be to userspace. It does this by adding a new
> > DAMOS action: DAMOS_INTERLEAVE. We implement DAMOS_INTERLEAVE with both
> > paddr and vaddr operations sets. Using the paddr version is useful for
> > managing page placement globally. Using the vaddr version limits tracki=
ng
> > to one process per kdamond instance, but the va based tracking better
> > captures spacial locality.
> >
> > DAMOS_INTERLEAVE interleaves pages within a region across nodes using t=
he
> > interleave weights at /sys/kernel/mm/mempolicy/weighted_interleave/node=
<N>
> > and the page placement algorithm in weighted_interleave_nid via
> > policy_nodemask. We chose to reuse the mempolicy weighted interleave
> > infrastructure to avoid reimplementing code. However, this has the awkw=
ard
> > side effect that only pages that are mapped to processes using
> > MPOL_WEIGHTED_INTERLEAVE will be migrated according to new interleave
> > weights. This might be fine because workloads that want their data to b=
e
> > dynamically interleaved will want their newly allocated data to be
> > interleaved at the same ratio.
>
> I think this is generally true. Maybe until a user says that they have a
> usecase where they would like to have a non-weighted-interleave policy
> to allocate pages, but would like to place them according to a set weight=
,
> we can leave support for other mempolicies out for now.
>
> > If exposing policy_nodemask is undesirable, we have two alternative met=
hods
> > for having DAMON access the interleave weights it should use. We would
> > appreciate feedback on which method is preferred.
> > 1. Use mpol_misplaced instead
> >   pros: mpol_misplaced is already exposed publically
> >   cons: Would require refactoring mpol_misplaced to take a struct vm_ar=
ea
> >   instead of a struct vm_fault, and require refactoring mpol_misplaced =
and
> >   get_vma_policy to take in a struct task_struct rather than just using
> >   current. Also requires processes to use MPOL_WEIGHTED_INTERLEAVE.
> > 2. Add a new field to struct damos, similar to target_nid for the
> > MIGRATE_HOT/COLD schemes.
> >   pros: Keeps changes contained inside DAMON. Would not require process=
es
> >   to use MPOL_WEIGHTED_INTERLEAVE.
> >   cons: Duplicates page placement code. Requires discussion on the sysf=
s
> >   interface to use for users to pass in the interleave weights.
>
> Here I agree with SJ's sentiment -- I think mpol_misplaced runs with the
> context of working with current / fault contexts, like you pointed out.
> Perhaps it is best to keep the scope of the changes as local as possible =
: -)
> As for duplicating page placement code, I think that is something we can
> refine over iterations of this patchset, and maybe SJ will have some grea=
t
> ideas on how this can best be done as well.

David Hildenbrand responded to this and proposed adding a new function that
just returns the nid a folio should go on based on its mempolicy. I think t=
hat's
probably the best way to go for now. I think the common case would want
the weights used by this and mempolicy to be the same. However, if there is
a use case where different weights are desired, I don't mind coming back an=
d
adding that functionality.

> > This patchset was tested on an AMD machine with a NUMA node with CPUs
> > attached to DDR memory and a cpu-less NUMA node attached to CXL memory.
> > However, this patch set should generalize to other architectures and nu=
mber
> > of NUMA nodes.
>
> I think moving the test results to the cover letter will help reviewers
> better understand the intent of the work. Also, I think it will also be
> very helpful to include some potential use-cases in here as well. That is=
,
> what workloads would benefit from placing pages according to a set ratio,
> rather than using existing migration policies that adjust this based on
> hotness / coldness?

Noted. I will be sure to include that in the next revision.

> One such use case that I can think of is using this patchset + weighted
> interleave auto-tuning, which would help alleviate bandwidth limitations
> by ensuring that past the allocation stage, pages are being accessed
> in a way that maximizes the bandwidth usage of the system (at the cost of
> latency, which may or may not even be true based on how bandwidth-bound
> the workload is).

This was the exact use case I envisioned for this patch. I talk about it in=
 more
detail in my reply to SeongJae.

> Thank you again for the amazing patchset! Have a great day : -)
> Joshua

I appreciate you taking the time to respond,
Bijan
