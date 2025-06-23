Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CB22B8B6
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720515; cv=none; b=clAoRQxjSs+s791z+q1gBE0IUYOV9IGxcNHHWVaxQeq2qoZbTHUqiRCXBgi5/jMexIYJdf/1wmqxMAr9dlJSfRjBzWC3J+eYiAOdyYy0rMhjmnR+rwEfBOlzkfCGwZm2CPvd7Q4A13yeHy7W21qsDL+As1SkHYeYBuv5NwvyBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720515; c=relaxed/simple;
	bh=1OVYvye3WwNSJ1YQjK+t/OdGujCoo45QeCBlw1cV2ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9m67EIm31i/s7UnmKmOPfBcBJwdgXiwH33UbnXR9eBbJdInXD5Ptm2Z5kzpnRGZS4fyVeLqR0M2oafvHHJYYUCzCrQ4w+kExLuJJzJpU78XnvRXD05sxHPhO2ETe6PwxLnhlpCP+/TmHaotFaSbLYCMfqUgCWEL4H967b2Fn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsGKlYPC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsGKlYPC"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso893918366b.3
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750720512; x=1751325312; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RBz2MH4vsF5+PtaFf3tYfQ96/rNjEiKL+V+vNB44KJo=;
        b=XsGKlYPCqy+g8E/qQXoY8IK8QJpwoXuHzJmiw2OoZx8Xl0HD0YRha77Rm1Za5k89+J
         6kF3ybCU9+xdB+V5nb9ca1SUGbq5UPgAtv0VqXAop3/06WmBDseqaZSrKElI11EX7cBh
         y6sb9ivSHJ8WARsKRbAxcaZSZ6JL+UrO5V464vuCuaZi23AN7qKhyIcmNRMFxsvdlC4K
         wjQwEOEB3qsevjL6RVpUx+hyRfyPTTCNmuIvrrkSY5sKqirK5HL0H9YmjMv+64zwwG9U
         OEjLYEbIPDMgWItXsb/OMMvihNqRPYGUP6KUYxU48tegoJbgtb58r7kH8dShrUZnvRSX
         gGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750720512; x=1751325312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBz2MH4vsF5+PtaFf3tYfQ96/rNjEiKL+V+vNB44KJo=;
        b=C3jChUC4cPrWmryAft01u+Pv+Q9f9KAwGt95+FxcOpfQwF5c4f34lHgF7aKd/om7Rg
         Y32oyaPblF3uahbf0VTzz0pVJzhYwnJWt1xrS6mdPsA1SijWYiv2iecMEpej7WlwNIvy
         nNZV/mn6j4EyjLq75d1a3ncQay5Hkjq6q6BgU1NDRKd5NHDXrZdaLIvESZNNH60i5lF6
         o1yzWsCY1g4w5EYVCc6VfMS7SiRiCPfDZN3KTum2yZ7QDwRcSGuRdUtPwBtF1Dy7F1yY
         wmar12BQyFIOU0pduDykr8aGM4MiPOkg+S0b9sug2fht2HHV3iuBUtGQU9rukmyWGWms
         DCSg==
X-Gm-Message-State: AOJu0YyKlL73xPCzABDI4ve9PTczm0fzm7Dn/SNx6ExtYJgDVK5Tl0CN
	3ZwOOsjrcMNDpQg9CLjdE1GqgBxS+SoLdT1ub8hrcoTGvJPYtpbWGYUrZou3LrvV6q2mrBxeXY2
	9pf7CY2T8d4dNbqryVOih5AfPPrywOus=
X-Gm-Gg: ASbGncuBzgHpNTgQkSBbU+ezggpKrvBRlK7b0qbn9jyVrOLrjGV/m7i7PTUVfb90zkd
	PP61rP0KSxLy4ZC/SrD/VGydByyRC4VJNtJs467ptIziiHIWtqqVMeCTAeB6Il91XLy+8yQqvKG
	JYFEyb8tG9hdOFidiZAG4XR9i614N7xqqnoUmKEHFCiGqG+sPPaZ+/fJz/OQLMXGu1RZUlFkuwA
	H4xUA==
X-Google-Smtp-Source: AGHT+IHPUSbUFt4gKmx35OTPDxKtucfsnWXLHwhuZC4RnoCwVMI4k/jbfXUbIDHmkbtMDZoocoQJrfWc9dwdbCAKytc=
X-Received: by 2002:a17:907:c295:b0:ade:422d:3168 with SMTP id
 a640c23a62f3a-ae057b6cc35mr1256632566b.37.1750720511655; Mon, 23 Jun 2025
 16:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAMvvPS5JL20OJic0EFKbuY_VgEAjveJoquTReyLjknSZ-6BeVQ@mail.gmail.com>
 <20250623175204.43917-1-sj@kernel.org>
In-Reply-To: <20250623175204.43917-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 23 Jun 2025 18:15:00 -0500
X-Gm-Features: AX0GCFvk3bD96yNp8E3FeZAJR62qRNVLNC4Ahk2Y4MIrtpo5yApquvrGtk5G1Ms
Message-ID: <CAMvvPS4CNzc7gSF8Z+6ogB212V+GDJyW9PXrrrP+wMyDNfXKqg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"

[...]
> Thank you for walking with me, Bijan.  I understand and agree your concerns.
> Actually, this kind of unnecessary ping-pong is a general problem for DAMOS.
> We hence made a few DAMOS features to avoid this issue.
>
> The first feature is 'age' reset.  DAMOS sets 'age' of regions to zero when it
> applies an action.  Hence if your DAMOS scheme has minimum 'age' for the target
> access pattern, the region will not be selected as action target again, very
> soon.
>
> The second feature is the quota.  You can set speed limit of a DAMOS action, to
> avoid DAMOS being too aggressive.  When DAMOS finds memory regions that
> eligible for a given action and larger than the given quota, it calculates
> access temperature of regions, and apply the action to only hottest or coldest
> regions of quota amount.  Whether to prioritize hotter or colder depends on the
> action.  DAMOS_MIGRATE_HOT prefers hotter one.  Together with the age reset,
> this can reduce unnecessary pingpong.
>
> The third feature is quota auto-tuning.  You can ask DAMON to adjust the quotas
> on its own, based on some metrics.  Let me describe an example with memory
> tiering use case.  Consider there are two NUMA nodes of different speed.  Node
> 0 is faster than node 1, samely for every CPU.  Then you can ask DAMON to
> migrate hot pages on node 1 to node 0 aiming 99% of node 0 memory be allocated,
> while migrating cold pages on node 0 to node 1 aiming 1% of node 0 memory be
> free.  Then, DAMON will adjust the quotas for two different schemes based on
> current node 0 memory used/free amount.  If node 0 memory is used less than
> 99%, hot pages migration scheme will work.  The aggressiveness will be
> determined on the difference between the current memory usage and the target
> usage.  For example, DAMON will try to migrate hot pages faster when node 0
> memory usage is 50%, compared to when node 0 memory usage is 98%.  The cold
> pages migration scheme will do nothing when node 0 memory is used less than
> 99%, since its goal (1% node 0 free memory ratio) is already over-achieved.
> When the node 0 memory usage becomes 99% and no more allocation is made, DAMON
> will be quiet.  Even if a few more allocations happen, DAMON will work in slow
> speed, and hence make only reasonable and healthy amount of noise.
>
> Back to your use case, you could set per-node ideal memory usage of
> interleaving as the quota goal.  For example, on the 1:1 ratio interleaving on
> 2 NUMA nodes, you could use two DAMOS scheme, one aiming 50% node 0 memused,
> and other one aiming 50% node 0 memfree.  Once pages are well interleaved, both
> schemes will stop working for unnecessary pingponging.
>
> Note that you can one of quota auto-tuning metric that DAMON support is
> arbitrary user input.  When this is being used, users can simply feed any value
> as current value of the goal metric.  For example, you can use application's
> performance metric, memory bandwidth, or whatever.  You could see the
> node0-node1 balance from your user-space tool and feed it to DAMON quota
> auto-tuning.  Then, DAMON will do more migration when it is imbalanced, and no
> more migration when it is well balanced.
>
> Finally, you can change DAMON parameters including schemes while DAMON is
> running.  You can add and remove schemes whenever you want, while DAMON keeps
> monitoring the access pattern.  Your user-space tool can determine how
> aggressive migration is required based on current memory balance and adjust
> DAMOS quotas online, or even turns DAMOS schemes off/on on demand.
>
> So I think you could avoid the problem using these features.  Does this make
> sense to you?
>
> In future, we could add more DAMOS self-feedback metric for this use case.  For
> example, the memory usage balance of nodes.  My self-tuning example above was
> using two schemes since there is no DAMOS quota goal tuning metric that can
> directly be used for your use case.  But I'd say that shouldn't be a blocker of
> this work.


Hi SeongJae,

I really appreciate your detailed response.
The quota auto-tuning helps, but I feel like it's still not exactly
what I want. For example, I think a quota goal that stops migration
based on the memory usage balance gets quite a bit more complicated
when instead of interleaving all data, we are just interleaving *hot*
data. I haven't looked at it extensively, but I imagine it wouldn't be
easy to identify how much data is hot in the paddr setting, especially
because the regions can contain a significant amount of unallocated
data. Also, if the interleave weights changed, for example, from 11:9
to 10:10, it would be preferable if only 5% of data is migrated;
however, with the round robin approach, 50% would be. Finally, and I
forgot to mention this in my last message, the round-robin approach
does away with any notion of spatial locality, which does help the
effectiveness of interleaving [1]. I don't think anything done with
quotas can get around that. I wonder if there's an elegant way to
specify whether to use rmap or not, but my initial feeling is that
might just add complication to the code and interface for not enough
benefit.

Maybe, as you suggest later on, this is an indication that my use case
is a better fit for a vaddr scheme. I'll get into that more below.

> > Using the VMA offset to determine where a page
> > should be placed avoids this problem because it gives a folio a single
> > node it can be in for a given set of interleave weights. This means
> > that in steady state, no folios will be migrated.
>
> This makes sense for this use case.  But I don't think this makes same sense
> for possible other use cases, like memory tiering on systems having multiple
> NUMA nodes of same tier.

I see where you're coming from. I think the crux of this difference is
that in my use case, the set of nodes we are monitoring is the same as
the set of nodes we are migrating to, while in the use case you
describe, the set of nodes being monitored is disjoint from the set of
migration target nodes. I think this in particular makes ping ponging
more of a problem for my use case, compared to promotion/demotion
schemes.

> If you really need this virtual address space based
> deterministic behavior, it would make more sense to use virtual address spaces
> monitoring (damon-vaddr).

Maybe it does make sense for me to implement vaddr versions of the
migrate actions for my use case. One thing that gives me pause about
this, is that, from what I understand, it would be harder to have
vaddr schemes apply to processes that start after damon begins. I
think to do that, one would have to detect when a process starts, and
then do a damon tune to upgrade the targets list? It would be nice if,
say, you could specify a cgroup as a vaddr target and track all
processes in that cgroup, but that would be a different patchset for
another day.

But, using vaddr has other benefits, like the sampling would take into
account the locality of the accesses. There are also ways to make
vaddr sampling more efficient by using higher levels of the page
tables, that I don't think apply to paddr schemes [2]. I believe the
authors of [2] said they submitted their patches to the kernel, but I
don't know if it has been upstreamed (sorry about derailing the
conversation slightly).

[1] https://elixir.bootlin.com/linux/v6.16-rc3/source/mm/mempolicy.c#L213
[2] https://www.usenix.org/conference/atc24/presentation/nair
