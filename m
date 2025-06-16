Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839A1C1F05
	for <damon@lists.linux.dev>; Mon, 16 Jun 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083430; cv=none; b=U2GEzOH70HrcPtS6X9wuLqsl/zUElUwUyIn5pEjHRdupcTyAY1EL8NDGqs9A5zEWNAYMJgHjijae5FOB3FkwDv/jNvg3U4ne3h3A8rzqqHDKyszdOZgEoIa/VF9KFQ7JszTJWZucDAgrUw+YZTshFkCp08cmDqF7Ihw6A+VJ3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083430; c=relaxed/simple;
	bh=eP6PuM+64K5CWtrRCBbwXKZnsU5mxw6QkvsFbixFqYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+b22kxJi0OnojXLHQbr5fhJVfWaNWfNJflNfmLTW9C3UaOvswpfk7sCkd6yA8hcywkBxuzIDgtFBVY1/FxRDN5e/7lqTpEUVlvfU7zGaA+dM9hv6Xv/frwcam0JoVItTOZ4X8z1wHCaPiaP9LqIy9/5EcMVbziW7Y9UNXTLnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXvW0sJl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXvW0sJl"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade58ef47c0so952382866b.1
        for <damon@lists.linux.dev>; Mon, 16 Jun 2025 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750083427; x=1750688227; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP6PuM+64K5CWtrRCBbwXKZnsU5mxw6QkvsFbixFqYU=;
        b=jXvW0sJluE2u/fFHHbvMsG40pyOKwelXBX3uOsyO0lSSKZCdKc7rBBSMz4f++Wn5Uh
         kVia3kpJJINIrBF8wPYyWl7hZUJa3k0crj0isDi6e5wu7ckH5ps38kd+IqGMLnpO0TsK
         u8cSxhryMpuMTlHB0Fb28uwLQBeYkwV0/3uT05PfdhjxHyOu7T3iKKD+S2ahn3GOWyBG
         c6psT2tm+tOWyrn+9NFHNQpInCqdHTRNQKJfDOHbNbr1v+LThuP70hRz7U832mRUJ3dR
         8DTaRtRCJpw73NRbRB8G491qhPZ8DFuofAHFTkKPMdM7KWhLZRVpLwy9cD0y/FTXxjQs
         BUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750083427; x=1750688227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP6PuM+64K5CWtrRCBbwXKZnsU5mxw6QkvsFbixFqYU=;
        b=t/iVSBs97UAqZAE/6Ycll2k8pBNE+2R1eAyz5G7jsjEpZqxWuyqT56/6hZQzlEKlGE
         sTh2pVh/Q7BtSJYaiTIZml6qISM0Pl36cKtEM8K4Bvn/JdiCMQVSLFykKCdZyiTxYd9f
         OHgEjquAvIKymGVHkC1cUlIVgNdrqaCPOuO5TCD4d+y+gW3JoZtnlwPsRFfy1N633Nrx
         BWXryiO2JK6FTcF7Y3sIdOFdgDtqMhQUt2fNNoZzGgy629EwgTtsLvIwY0NF0o8qw0n3
         2/oHyl8aP+afV4YhSbmxMWp0qOzECFz/hQOJEdrBM3n/3rThqBjvVV9Gw3v47FRr4V9U
         /+KA==
X-Forwarded-Encrypted: i=1; AJvYcCW+cET+MuLtscQRWQvR0jpqAEAPswIbo/gSBrFXQzfbG0fNNnV5QhgxEFkxEFvXW/azl16pdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1lxGHXCALtbZdapPPCvMmUB2XrXdPK8+NCulc7pxnWH0H+seF
	m7PU2QxQxVFebz6oNszunLY2iMRZ93+I0lfVRZHQvWfAzC19V7rGbH5OsxQZGJUTu2Ep58WUrP8
	SPQfzhgoeqs5A5LG9sAzF47P+ljNKwjg=
X-Gm-Gg: ASbGncs8oAkOfoWRGQ31/LTa5IrcS+1T1Xg3mK5pTVDR6KHGKG6zBdTLTbgI2GrhCK9
	MTK+H7zbsLSI7UPL7vOB/J+Wc3DM4qGVITmT4/o+libp2IxEiFqh8DrefAqzyu9BU+hoCRomVob
	yg0FdiqycSJjGsN+mQvkuyOH/bo8ubFEduXYOQI+nKhb0QlO+yejAYmjLWR7BDbU+sBDSNmcMx4
	suuwA==
X-Google-Smtp-Source: AGHT+IG36AYu/aqp41xnF1pJkXFnqEk2HCgmA8jDS9zdCLJ74WU28G5N0cZpsN3g7yXaxRPiI8ZvSI/MMogdMmVSBfg=
X-Received: by 2002:a17:906:9fc5:b0:ad8:6dc0:6a8a with SMTP id
 a640c23a62f3a-adf9bfdd52fmr854559366b.1.1750083426656; Mon, 16 Jun 2025
 07:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612181330.31236-1-bijan311@gmail.com> <20250612181330.31236-2-bijan311@gmail.com>
 <5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com> <CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
 <e40aa590-f0a2-4666-84b0-c33c8f4fef87@redhat.com>
In-Reply-To: <e40aa590-f0a2-4666-84b0-c33c8f4fef87@redhat.com>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 16 Jun 2025 09:16:55 -0500
X-Gm-Features: AX0GCFtYGWGWkDqtRWR9qfiUop7Yc8zxOn5BNjJ8enw3Dihp3CCnDxICYmQLo6k
Message-ID: <CAMvvPS5bTUfAXy4g79tAq+1DWKX79b33Jt=UNBg-xR9BDa7FdA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in include/linux/mempolicy.h
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj@kernel.org, akpm@linux-foundation.org, 
	corbet@lwn.net, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com, 
	ajayjoshi@micron.com, vtavarespetr@micron.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 4:46=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.06.25 18:33, Bijan Tabatabai wrote:
> > On Fri, Jun 13, 2025 at 8:45=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 12.06.25 20:13, Bijan Tabatabai wrote:
[...]
> Hi,
>
> >
> > I did not use get_vma_policy or mpol_misplaced, which I believe is the
> > closest function that exists for what I want in this patch, because
> > those functions
>
> I think what you mean is, that you are performing an rmap walk. But
> there, you do have a VMA + MM available (stable).
>
> > seem to assume they are called inside of the task that the folio/vma
> > is mapped to.
>
> But, we do have a VMA at hand, so why would we want to ignore any set
> policy? (I think VMA policies so far only apply to shmem, but still).
>
> I really think you want to use get_vma_policy() instead of the task polic=
y.

Sorry, I think I misunderstood you before. You are right, we should
consider the VMA policy before using the task policy. I will do this
in the next revision.

>
> > More specifically, mpol_misplaced assumes it is being called within a
> > page fault.
> > This doesn't work for us, because we call it inside of a kdamond proces=
s.
>
> Right.
>
> But it uses the vmf only for ...
>
> 1) Obtaining the VMA
> 2) Sanity-checking that the ptlock is held.
>
> Which, you also have during the rmap walk.

There is another subtle dependency in get_vma_policy.
It first checks if a VMA policy exists, and if it doesn't, it uses the
task policy of the current task, which doesn't make sense when called
by a kdamond thread.

However, I don't think this will change what seems to be our consensus
of adding a new helper function.

>
> So what about factoring out that handling from mpol_misplaced(), having
> another function where you pass the VMA instead of the vmf?
>
> >
> > I would be open to adding a new function that takes in a folio, vma,
> > address, and
> > task_struct and returns the nid the folio should be placed on. It could=
 possibly
> > be implemented as a function internal to mpol_misplaced because the two=
 would
> > be very similar.
>
> Good, you had the same thought :)
>
> >
> > How would you propose we handle MPOL_BIND and MPOL_PREFFERED_MANY
> > in this function? mpol_misplaced chooses a nid based on the node and
> > cpu the fault
> > occurred on, which we wouldn't have in a kdamond context. The two optio=
ns I see
> > are either:
> > 1. return the nid of the first node in the policy's nodemask
> > 2. return NUMA_NO_NODE
> > I think I would lean towards the first.
>
> I guess we'd need a way for your new helper to deal with both cases
> (is_fault vs. !is_fault), and make a decision based on that.
>
>
> For your use case, you can then decide what would be appropriate. It's a
> good question what the appropriate action would be: 1) sounds better,
> but I do wonder if we would rather want to distribute the folios in a
> different way across applicable nodes, not sure ...

Yes, I was thinking about that too, but I felt that adding state
somewhere or using randomness to distribute the folios was incorrect,
especially since those policies are not the focus of this patchset.

I think I'll move forward with option 1 for now.

Thanks,
Bijan
