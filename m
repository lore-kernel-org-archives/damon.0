Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377B846F
	for <damon@lists.linux.dev>; Mon,  4 Aug 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320784; cv=none; b=dACVYOd3beJYeYlYmaBkXqRhZB/BQjvX1uKsIfQmJIAcOgWZVL/vnWjs5tBt6CXyWDotx8unCbsxI/jRa8q2X7X+n05MwRDymu2PXUzSS4LigmK92lfDsYJCdvBUwVX2g3Y/JSwz3Q7S1YZlgXIrH/8OW8exkeK+hnad/wcx/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320784; c=relaxed/simple;
	bh=b4aBqY9Ms4Uu/zCw+++ztS5QKPyr08QVajKPTitIAY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEIPfBtTvfR2gpz1Wz7Upxrf/N3J/zs1nE5KFPtSVCfGqmGRhdIxKeeB+FM5LXEM3pYWXaKLshvXm5zQUX+fDoKvDd3cpcjqFtu9FGCrUR/NObIM4t69d77pOxRVbvBrwrdbGhkJwgEYBN6/Zqwz+8BG7YN/DcVIVFTckkkOeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZojmDzI; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZojmDzI"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8d96ff2dfaso4072660276.2
        for <damon@lists.linux.dev>; Mon, 04 Aug 2025 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754320782; x=1754925582; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPQi+IA3R1dRnGdKexIi0XDqQRWsjPMmJO8JnBD6qzY=;
        b=lZojmDzIRuCtLg9MDaQeXvPb1w4VVyepXAPcnrjEukes5OmuUdaD9moVCR+G3PpZnV
         ESlZYbIJNQbfbkYPpAI8u20nCR6OmkENyuIFzefFMDYaIrR7mkiMxMoq5BdSkqxKwENr
         ISD+9qJYUNlVRjSuXFpHmcINfcFmza9gyqE3YtvTPa9QyGl2pYdirqygLNiLvLdQvh1W
         a+9bDZLD+7So/L7tAzGqGVye81yVKgglNtDBuMhB9Csbp53YkVyHG0JZBPc66Ja+llS8
         oH5X+boXkRqEHcsmKVeyKlljIcX3TKOD7tOUNaBrLM+C2wUG6wH5z2RVNc3LqUiEASxv
         /SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320782; x=1754925582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPQi+IA3R1dRnGdKexIi0XDqQRWsjPMmJO8JnBD6qzY=;
        b=fIyn2SMRficIlyc+lpa0sCL6RFwDja8R4oiGvSXT4ZzBQtMhJbRMDEt1wgGlCzJXfT
         IQpoULo3EZ9bYFsZVTBhyYj7DlpbF6jNwYYnbp3I9jTRtUSVMlmQ5ICL+OvLELAzpduu
         rADLdz8ara4rCMgpJadHbtu/CSX6Dr8S1iW/uS2zIfkiw7bvpmbxj1qC+AMrIkeo5ruO
         nMM8t74nM6dOO4PaEiqTDuzfMtu/sWWM+DYfDupaEFARJ8muMp3eQd25pZ2Lic/n9Jbi
         VcgKCXwMhGKKJ4yNn5zJ2qZE63FIVvA+Hj5NtbfjhMdLV0zNV7T9IEF3v5GBN1NU3wnG
         1pNw==
X-Forwarded-Encrypted: i=1; AJvYcCUZs+vDEy2P8TqUFA3bCC0DpqBrmVSBURPML0c8iCpbrNATZctw3RdV2kOwxZuKkPfizXTlXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuXKh0tLvQPgTlP+q+107HQhn2ByxOy/+p/TeEZ7SYhid5B38G
	JlMisYcaxqHEoYXWR1fOz4a2cBibQTklpVHwstz4xjIDXpqEAjhw/oG7TjdUIw==
X-Gm-Gg: ASbGncu2usdK64AyPaj1FtMO9O8ifDSNJyZgax4IBcYl6BDNhphMiWHhClftgAYBiMo
	aUxV9Bpv4WYUTuXRl6CdtS1aLvQX1mRceyZkmsHgXfEGw2s5Z7nMpYz2PMsdxhic/882saKbtYb
	kHaYQuHZkC/ufNPzQ3k/Uw/DNhQp48/TGUBY1hm9qPnmnRPL8FbooIP+NTrbQmBaXZ+HQgjmebN
	wOYcpcjlo4ApkmwldKqi8mCgVPkSS+ZBmgO1OC+JCuEp19uARKI9seM3ReCN4n3w/+XO7Y0otBz
	IoZ2q6YkbB/uVuu4q2PhwUZbqb8i+aWids5IKHqLlvnkBT+bs/rd2Dpyfdq7sIoL8bgu2n61WJw
	VgW6XHz8ohKtR7mq38dJMP623Cj0D0DoWbfn4sJCubibfWfKSj0u0mg==
X-Google-Smtp-Source: AGHT+IFlGw47PgzrhuwUCbtTIH263RC0Rcfc+/vlsGvlDmq+dkNmzC8b3RhuI1Q9Dopja2mxJqIw+A==
X-Received: by 2002:a05:6902:1613:b0:e8e:1d34:6a47 with SMTP id 3f1490d57ef6-e8fee1a3aacmr9761715276.31.1754320781669;
        Mon, 04 Aug 2025 08:19:41 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:ca94:4c25:4381:5311])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3860b42sm3896506276.25.2025.08.04.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:19:41 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Bijan Tabatabai <bijan311@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon/vaddr: avoid unnecessary migration between target nodes
Date: Mon,  4 Aug 2025 10:19:20 -0500
Message-ID: <20250804151929.4613-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAC5umyg8eje0C8i6KTQPUXgi8O8S3p1TsGe6-1VKr3vRJ=Ao7g@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 4 Aug 2025 21:46:49 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Hi,
> 
> 2025年8月4日(月) 3:01 SeongJae Park <sj@kernel.org>:
> >
> > Hello Akinobu,
> >
> > On Sun,  3 Aug 2025 22:00:28 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > This change avoids unnecessary migration by checking if the folio to which
> > > the migration is applied is already located in one of the target nodes.
> >
> > Each folio will get a single target node among the target nodes, based on the
> > weights of targets and the virtual address of the folio.  So skipping the
> > migration because the folio is on one of target nodes can result in wrong
> > behavior (not doing required migrations)?
> >
> > Also, a similar purpose optimization was already made by Bijan.  I guess you
> > aware of that and therefore Cc-ed Bijan.  Could you further share differences
> > between this and Bijan's one, and measured additional performance gain from
> > this patch, if you have?
> >
> > [1] https://lkml.kernel.org/r/20250725163300.4602-1-bijan311@gmail.com
> 
> In my current DAMON setup, the target nodes for migrate_hot action
> are 0-3, and for migrate_cold action, they are 4 and 5.
> 
> I'm looking for a way to prevent unnecessary movement between target
> nodes for each action, making interleaving an optional choice. For
> instance, I'd like to avoid migrations from node 4 to node 5 during a
> migrate_cold action.

Where a folio is placed is based on the virtual address of the folio and
the folio's offset from the start of the VMA it is in. So, as long as the
interleave weights and the folio's offset in the VMA are the same, folios
should not be migrated after being placed. This placement algorithm is the
same as the one used for mempolicy weighted interleaving.

It sounds like you are keeping the interleave weights constant, and I would
imagine that the virtual addresses the folios are mapped to are constant,
so I'm guessing the start address of some VMAs are changing. I don't think
I've seen the bahvior your describing in the workloads I've run, but I
guess it's possible if VMAs are being merged or broken up a lot, such as
through frequent mmaps/munmaps. Do you think something like this is
happening in your workload?

How often are the undesired migrations happening? Every time the scheme is
applied?
Also, would you be willing to share how you are configuring DAMON?

> I've observed a difference in behavior compared to Bijan's patch, and
> it seems there's a need for both approaches. Would it be possible to
> introduce a new option that allows us to specify whether interleaving
> is forced or optional, and then adjust the behavior based on that
> setting?

I wonder if this would be better handled as a paddr scheme. That way
you can configure the schemes such that only physical addresses in nodes
4-5 will migrate pages to nodes 0-3, and only physical address in nodes 0-3
will migrate to nodes 4-5.

Bijan
