Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76791FE477
	for <damon@lists.linux.dev>; Fri, 13 Jun 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831191; cv=none; b=gTxjeL0QNS3aJ0C/VG7qdhzHEIAvuX6Sb+cv27vDxHim/oDs+PulKpbISpk0FWpToX9FYRLX9tiV5EPtyyojxMqqMlNziKxZK6OApFCojwqiqDKwvC745PwpeZ/jvG4NrEuRbonNtNy9AgDIilRqd8Xl4IsRAtdDRQd/cDEb1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831191; c=relaxed/simple;
	bh=8pQuheicsXT+hM8tp9m9C5NSjcZ0mAhehkxnWitrpno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0z74KXSxOeA7204/nnOiO7H2eiuZ+qJ3Oh+MAxMnNWT/Ew/ZE/bo4By/g4vP+5Jy9nR5hRiReM7ZS/n6KcN1LgM7tdm6nLaZomDDYUftkThfsfUA+L/8UxFXyfFsEZraRRU6opIP1pwGYi3v5t8d5mrF9CsX4CbKF+6W9A6IpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIc2sWOp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIc2sWOp"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade750971f2so287066466b.2
        for <damon@lists.linux.dev>; Fri, 13 Jun 2025 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749831188; x=1750435988; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+VwKYoq4K6K/5yHVH5q1Qz6OOz6+/W6hIZOp3rpGbI=;
        b=QIc2sWOp9XoMDBpSFlpMK9/M3weQOPGVclnI73ePR/QM2EZB8NORYr076VhAdSO5C/
         kSA/WpbTLo7hCa0jdpbOUM+TLyWE9gef9mRYbu9AR5/eATlaDUu7dpKUSHkVt9OWLt3e
         n3iRo1Nx7CP789J9dt2w7kzgZ7o8/217lsTKgh58DhtJJVme+P5pyKkTftu5c3IG6UM3
         Z38GsXJAApmEsdv6DagCcaDB8B1+UqPlCi6rLd0DfseHVg6iFfQ8yejpYajW4CN8FXt1
         7vThyQXjM0SSOMHi2dFfb88/jqOwbFoU7VeW28nScSwQA1F6mlcDrO88Xd7aHdW9EXFT
         973w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749831188; x=1750435988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+VwKYoq4K6K/5yHVH5q1Qz6OOz6+/W6hIZOp3rpGbI=;
        b=F17udqfZEG+pcoOYdnpibBuETwfgq1jrVqlT1MaqfIzBozlQY6p0Sg1hvXjGJgjMXy
         5V9MUSexa4qzgGKJCbJ4dVS8Vh/heR8THgzlgLVOEBrmfyIbgVoiEbGHA1Jly0eHGgdK
         vXfPTneFEv9Whs6LMFyBx3DrCt71MMpHtmkNwBZdq2f57wmyaYBkDDNrgXyuViK9NhcN
         L38lShlOa8GyKeI/GzjQeWKeH4QmozgcehmprSeVw68vb/LeOY2+a5GD0KsjndhnKyzU
         EFqJD8Zi4yuTGjBY+oFfW8soVMfFdzL/QkvW8u2YjlnxRHQI9oTm31qWo3VWn2eVsvqt
         9jmA==
X-Forwarded-Encrypted: i=1; AJvYcCX3KGwi+q42s2xO5hqzGs13qm/I4xk89x1cETfwpnGEKxNDGp8LzZPh7L7lMZSuaBbQ21Gr0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzhf3rG+S77ADV1NxxcmpWRkqKiDiLPzKecJiGijzZFPRoESqSR
	3KW20jC361McF6xWW6TVKSHl73G0EvYaR7Wpnh4O9Ax4uvkCpMEtZdRvRVhGJ3OK8OfIbCUFTw8
	Ny5pkyW82fDTz0RQcpij5uML4X4L2AJU=
X-Gm-Gg: ASbGncsFK8FdY+dZCK46qBKcuylzOtOuU0h1AKpNZfQnIh/A/t32i1CC5C7uQnnEnn/
	5ngh9BBceThy8dtu8iKP309V3haLRSy49Hs7xqFQ50w1BQjaztOhc+glcYjPqNkRMvQjqPtEdD+
	NX2DB9bFN1YVHtw1GV7Fxg6nHXmr9SBbYdpCesrP62uaeVDtGrKeLXZUU7mwLxmesr4aMF1wQq4
	ewU
X-Google-Smtp-Source: AGHT+IFfbm2ILbzNqaWeP+BPo+t/ZcGuAqPpA1yn78O51dNA9iM+X1CfAQz9tF1EH2JVkFqRrrq4xtngmwFGJQB2JJE=
X-Received: by 2002:a17:907:970f:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-adec5622d75mr357900366b.22.1749831187984; Fri, 13 Jun 2025
 09:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612181330.31236-1-bijan311@gmail.com> <20250613095525.1845-1-rakie.kim@sk.com>
In-Reply-To: <20250613095525.1845-1-rakie.kim@sk.com>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Fri, 13 Jun 2025 11:12:56 -0500
X-Gm-Features: AX0GCFvh-zD9qUo9qgFI77L0Qw-QGCNYqP0mhIl0FpPrr_nZ3onLg5ACPH5Ji9E
Message-ID: <CAMvvPS7qgos5OFo=W_FftEn=3QqbsxKCR_-3_eiTQeqne_Yj1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: Add DAMOS action to interleave data
 across nodes
To: Rakie Kim <rakie.kim@sk.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 4:55=E2=80=AFAM Rakie Kim <rakie.kim@sk.com> wrote:
>
> On Thu, 12 Jun 2025 13:13:26 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > A recent patch set automatically set the interleave weight for each nod=
e
> > according to the node's maximum bandwidth [1]. In another thread, the p=
atch
> > set's author, Joshua Hahn, wondered if/how these weights should be chan=
ged
> > if the bandwidth utilization of the system changes [2].
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
>
> Hi Bijan,
>
> Thank you for explaining the motivation and need behind this patch.
> I believe it's important to consider the case where a new memory node
> is added and the interleave weight values are recalculated.
>
> If a new memory node (say, node2) is added, there are two possible
> approaches to consider.
>
> 1. Migrating pages to the newly added node2.
>    In this case, there is a potential issue where pages may be migrated
>    to node2, even though it is not part of the nodemask set by the user.
>
> 2. Ignoring the newly added node2 and continuing to use only the existing
>    nodemask for migrations.
>    However, if the weight values have been updated considering node2
>    performance, avoiding node2 might reduce the effectiveness of using
>    Weighted Interleave.
>
> It would be helpful to consider these two options or explore other
> possible solutions to ensure correctness.
>
> Rakie

Hi Rakie,

Thank you for the reply - this is not a problem I considered, but it
is important.

I think option 2 is the correct choice, and is what is already done by the
policy_nodemask function we use to determine what node to place a page. I
do not think it makes sense to ignore the nodemask when it is explicitly se=
t by
the user.
However, if we decide to change the way we get the interleave weights to be=
 from
a DAMON specific interface, then I think it would make sense to only
migrate to the
newly onlined node if the user sets a weight for that node. This is
because in that
case, the user is explicitly telling DAMON to use that node.

Let me know if you have any other concerns,
Bijan
