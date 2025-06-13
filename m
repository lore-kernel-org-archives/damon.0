Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7815689A
	for <damon@lists.linux.dev>; Fri, 13 Jun 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829472; cv=none; b=uQY97h08ROJbQmtK0ST8LjWB40xI50eu0YknGRosKfanbRP3MD8O7pBkS4JAREJuk0OKU9/MglHY2Px85sLnbGe0B8m02BoSXpC5M7Mwv3GqL5p7R/1nZ3BOT8ONkqpydR2QUfsqag4q/hgNjds/chcA/+vuk9n+nRYvdmdxPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829472; c=relaxed/simple;
	bh=lHWaMSgSm6GARqQwls4srLX0MM6effcB3X6vbFDj0EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgrMOJWFVdD4ixBWyc31yUPDyxfu+Ij8n/26EVCWy2W6wbHFdxqwtrkGClkA9pFcIK9SAYMIFqVKtNIOH24gfGnQBXimBFTsAzISksfnsRYutVSMnC2eYt1jIj4TeONOmbJ4FQfjBYt42C0rAiR8XCHT85ZzKhziXOuMtt7ooBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEP3JZVX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEP3JZVX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so300896766b.0
        for <damon@lists.linux.dev>; Fri, 13 Jun 2025 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749829469; x=1750434269; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+LPfZ5t7fhqZqWzsU1eXpD5hJBJD8fKBtnn6IotxJ8=;
        b=PEP3JZVXJrimKrBVPxXAmq4eJNEuIld+f6O7xQxQGVB2OEGccXJ6t2tGJxdvCzzMBF
         eiiUKzW1WOhn+6Yii3FPEkkkATEa2IDO1FYFCVkSbiYBz2W6oNfAQp8s5jCB7DxIIsqA
         rbmTACNorKa9PdBvQ70YUrFGXwcFoePyX9vOh2ma/EkiBQv7xmncFwSAsrxv/VG+WcG5
         6MmxLN+TN9hLe8NjJsnGUCOWFHRFw9v6srVEJwZ4KX5Wl/8kyXz+gVHAodsZPaGVm37m
         9z4wxrZoMKXtahHde/e+XK+Zp/OyGtdb6n3h8zDLue/SXND0pCcYot3ClnzFtZTMqHXr
         6kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749829469; x=1750434269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+LPfZ5t7fhqZqWzsU1eXpD5hJBJD8fKBtnn6IotxJ8=;
        b=V2LHzR08Lr0J1VzZL1oU1xnr4OV8Svc/oEW7qBEkAmtVjxNkXxJTEuCfXQoitzVduI
         fEluFRkafq89GYQyUQjcPOLoTnAwKA9UiiffOLD7O/rYObSrIC/FU/S5B+k6AWx4zRkv
         UaEZFYX/vDsLhTrpS00Efo3BKWXkbYr91oCzZYJKbAi2ZpmWBh0UeCS5A40PaBind0Vs
         /LiwogmnQfzUmqjwTzi/zSfrwkUCgH7LeZ978kwiEfNJhYO+si2NVd+fhwi3Fgp47VFI
         SV7QUvl5FD/C66m+t8r/DbiyfivVZ8Pt32cGLUhvP3gcH30JzZg+DO7UAo7k9Cf3qLtr
         u6jg==
X-Forwarded-Encrypted: i=1; AJvYcCVE//OSN9a1kVhuJq4OXS8j0uvqZYeJ/dShHHvcPPcVi2mVi1Rte8eusVkwspTutq+va7g7iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYioStpBhdZdLXbT5sYniB6mGoifPgeyOmCxFWda3A+eTFIbeo
	OSIFGpRezc7zg/VtENXRFN0WktGy9Ha3KUZ4AjMmXtRqJm7j11pJThUSCibYTKFQ3fnRuiErGM6
	LjZWeo995BC0xKIsvMP2v2XG6X9Ed1aA=
X-Gm-Gg: ASbGnctBvwoQwaFV/eD2++9O5M9w2+XnYL/ATXADn5yjoWc3eeRsFcQ5dHO2VWPfnfW
	FlKJvmH2UFjh7k3p5v4lLkHOTEOa6IYTOn5MVX8wEeekhRYn9Hj/pc9p0i/h4gdyNAIZYgr6vhl
	+x1OsN5ZZ1bYmFTCaRYYNnGIEya/MN9AzJgAQnaYG4tXxdh9div3DHNITNmQ6q8XRgOFnYpfbz9
	P8x
X-Google-Smtp-Source: AGHT+IHEr6e5M63jg9UzcKzpMm3AWuL1o22D+HprFeAbRMxHRm3yE6PVP3CpGsjLPstSWMI3sHNGKhJMlVfa+X13oWc=
X-Received: by 2002:a17:907:1c15:b0:ade:33e9:3e66 with SMTP id
 a640c23a62f3a-adec5cbb4damr408152066b.58.1749829468579; Fri, 13 Jun 2025
 08:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612181330.31236-1-bijan311@gmail.com> <20250612234942.3612-1-sj@kernel.org>
In-Reply-To: <20250612234942.3612-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Fri, 13 Jun 2025 10:44:17 -0500
X-Gm-Features: AX0GCFvhUAxSnlXv30h-oxxWpil44Zym0NFsmT7QhN4nZIX7gjTmNSVKeWv1L90
Message-ID: <CAMvvPS4WsGkfukNscnLWW40Agg6_wmkm_QF96m+HZrEZrstR4A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: Add DAMOS action to interleave data
 across nodes
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	david@redhat.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com, 
	ajayjoshi@micron.com, vtavarespetr@micron.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae,

Thank you for your comments.

On Thu, Jun 12, 2025 at 6:49=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Bijan,
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
> Thank you for sharing the background.  I do agree it is an important ques=
tion.
>
> >
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
> > policy_nodemask.
>
> So, what DAMOS_INTERLEAVE will do is, migrating pages of a given DAMON re=
gion
> into multiple nodes, following interleaving weights, right?

That's correct.

> We already have
> DAMOS actions for migrating pages of a given DAMON region, namely
> DAMOS_MIGRATE_{HOT,COLD}.  The actions support only single migration targ=
et
> node, though.  To my perspective, hence, DAMOS_INTERLEAVE looks like an
> extended version of DAMOS_MIGRATE_{HOT,COLD} for flexible target node
> selections.  In a way, DAMOS_INTERLEAVE is rather a restricted version of
> DAMOS_MIGRATE_{HOT,COLD}, since it prioritizes only hotter regions, if I =
read
> the second patch correctly.
>
> What about extending DAMOS_MIGRATE_{HOT,COLD} to support your use case?  =
For
> example, letting users enter special keyword, say, 'weighted_interleave' =
to
> 'target_nid' DAMON sysfs file.  In the case, DAMOS_MIGRATE_{HOT,COLD} wou=
ld
> work in the way you are implementing DAMOS_INTERLEAVE.

I like this idea. I will do this in the next version of the patch. I
have a couple of questions
about how to go about this if you don't mind.

First, should I drop the vaddr implementation or implement
DAMOS_MIGRATE_{HOT,COLD}
in vaddr as well? I am leaning towards the former because I believe
the paddr version is
more important, though the vaddr version is useful if the user only
cares about one
application.

Second, do you have a preference for how we indicate that we are using
the mempolicy
rather than target_nid in struct damos? I was thinking of either
setting target_nid to
NUMA_NO_NODE or adding a boolean to struct damos for this.

Maybe it would also be a good idea to generalize it some more. I
implemented this using
just weighted interleave because I was targeting the use case where
the best interleave
weights for a workload changes as the bandwidth utilization of the
system changes, which
I will go describe in more detail further down. However, we could
apply the same logic for
any mempolicy instead of just filtering for MPOL_WEIGHTED_INTERLEAVE. This =
might
clean up the code a little bit because the logic dependent on
CONFIG_NUMA would be
contained in the mempolicy code.

> > We chose to reuse the mempolicy weighted interleave
> > infrastructure to avoid reimplementing code. However, this has the awkw=
ard
> > side effect that only pages that are mapped to processes using
> > MPOL_WEIGHTED_INTERLEAVE will be migrated according to new interleave
> > weights. This might be fine because workloads that want their data to b=
e
> > dynamically interleaved will want their newly allocated data to be
> > interleaved at the same ratio.
>
> Makes sense to me.  I'm not very familiar with interleaving and memory po=
licy,
> though.
>
> >
> > If exposing policy_nodemask is undesirable,
>
> I see you are exposing it on include/linux/mempolicy.h on the first patch=
 of
> this series, and I agree it is not desirable to unnecessarily expose func=
tions.
> But you could reduce the exposure by exporting it on mm/internal.h instea=
d.
> mempolicy maitnainers and reviewers who you kindly Cc-ed to this mail cou=
ld
> give us good opinions.
>
> > we have two alternative methods
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
>
> I feel cons is larger than pros.  mpolicy people's opinion would matter m=
ore,
> though.
>
> > 2. Add a new field to struct damos, similar to target_nid for the
> > MIGRATE_HOT/COLD schemes.
> >   pros: Keeps changes contained inside DAMON. Would not require process=
es
> >   to use MPOL_WEIGHTED_INTERLEAVE.
> >   cons: Duplicates page placement code. Requires discussion on the sysf=
s
> >   interface to use for users to pass in the interleave weights.
>
> I agree this is also somewhat doable.  In future, we might want to implem=
ent
> this anyway, for non-global and flexible memory interleaving.  But if mem=
ory
> policy people are ok with reusing policy_nodemask(), I don't think we nee=
d to
> do this now.
>
> >
> > This patchset was tested on an AMD machine with a NUMA node with CPUs
> > attached to DDR memory and a cpu-less NUMA node attached to CXL memory.
> > However, this patch set should generalize to other architectures and nu=
mber
> > of NUMA nodes.
>
> I show the test results on the commit messages of the second and the four=
th
> patches.  In the next version, letting readers know that here would be ni=
ce.
> Also adding a short description of what you confirmed with the tests here
> (e.g., with the test we confirmed this patch functions as expected [and
> achieves X % Y metric wins]) would be nice.
>

Noted. I'll include this in the cover letter of the next patch set.

> >
> > Patches Sequence
> > ________________
> > The first patch exposes policy_nodemask() in include/linux/mempolicy.h =
to
> > let DAMON determine where a page should be placed for interleaving.
> > The second patch implements DAMOS_INTERLEAVE as a paddr action.
> > The third patch moves the DAMON page migration code to ops-common, allo=
wing
> > vaddr actions to use it.
> > Finally, the fourth patch implements a vaddr version of DAMOS_INTERLEAV=
E.
>
> I'll try to take look on code and add comments if something stands out, b=
ut
> let's focus on the high level discussion first, especially whether to imp=
lement
> this as a new DAMOS action, or extend DAMOS_MIGRATE_{HOT,COLD} actions.

Makes sense. Based on your reply, I will probably change the code significa=
ntly.

> I think it would also be nice if you could add more explanation about why=
 you
> picked DAMON as a way to implement this feature.  I assume that's because=
 you
> found opportunities to utilize this feature in some access-aware way or
> utilizing DAMOS features.  I was actually able to imagine some such usage=
s.
> For example, we could do the re-interleaving for hot or cold pages of spe=
cific
> NUMA nodes or specific virtual address ranges first to make interleaving
> effective faster.

Yeah, I'll give more detail on the use case I was targeting, which I
will also include
in the cover letter of the next patch set.

Basically, we have seen that the best interleave weights for a workload can
change depending on the bandwidth utilization of the system. This was touch=
ed
upon in the discussion in [1]. As a toy example, imagine some
application that uses
75% of the local bandwidth. Assuming sufficient capacity, when running alon=
e, we
probably want to keep all of that application's data in local memory.
However, if a
second instance of that application begins, using the same amount of bandwi=
dth,
it would be best to interleave the data of both processes to alleviate
the bandwidth
pressure from the local node. Likewise, when one of the processes ends, the=
 data
should be moved back to local memory.

We imagine there would be a userspace application that would monitor system
performance characteristics, such as bandwidth utilization or memory
access latency,
and uses that information to tune the interleave weights. Others seemed to =
have
come to a similar conclusion in previous discussions [2]. We are
currently working
on a userspace program that does this, but it's not quite ready to be
published yet.

After the userspace application adjusts the interleave weights, we need som=
e
mechanism to migrate the application pages that have already been allocated=
.
We think DAMON is the correct venue for this mechanism because we noticed
that we don't have to migrate all of the application's pages to
improve performance,
we just need to migrate the frequently accessed pages. DAMON's existing hot=
ness
tracking is very useful for this. Additionally, as Ying pointed out
[3], a complete
solution must also handle when a memory node is at capacity. The existing
DAMOS_MIGRATE_COLD action can be used in conjunction with the functionality
in this patch set to provide that complete solution.

[1] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.hahnjy=
@gmail.com/
[2] https://lore.kernel.org/linux-mm/20250314151137.892379-1-joshua.hahnjy@=
gmail.com/
[3] https://lore.kernel.org/linux-mm/87frjfx6u4.fsf@DESKTOP-5N7EMDA/

> Also we could apply a sort of speed limit for the interleaving-migration =
to
> ensure it doesn't consume memory bandwidth too much.  The limit could be
> arbitrarily user-defined or auto-tuned for specific system metrics value =
(e.g.,
> memory bandwidth balance?).

I agree this is a concern, but I figured DAMOS's existing quota mechanism w=
ould
handle it. If you could elaborate on why quotas aren't enough here,
that would help
me come up with a solution.


> If you have such use case in your mind or your test setups, sharing those=
 here
> or on the next versions of this would be very helpful for reviewers.

Answered above. I will include them in the next version.

Thanks,
Bijan

> >
> > [1] https://lore.kernel.org/linux-mm/20250520141236.2987309-1-joshua.ha=
hnjy@gmail.com/
> > [2] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.ha=
hnjy@gmail.com/
>
>
> Thanks,
> SJ
>
> [...]
