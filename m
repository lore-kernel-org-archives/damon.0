Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C68221F17
	for <damon@lists.linux.dev>; Fri, 20 Jun 2025 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750456061; cv=none; b=P+2puNr9nBAMh2eL/PlmeD63YKFfOn0QtxfSgbZaHakguWSGw/I4UI3bIi6VQMw4bUm0ttxibunBWw82ufCVd2Qjyz0KRSHz8SlN2YFvNfiKT6R+f+Bh0HRo0KCvhTifX6da0VTmLcqApNq2QZFktcSgGbB1UfO7/EJnGyPe844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750456061; c=relaxed/simple;
	bh=Wa+uWIqB4aZ8UY7tQj9IFQRBuVASDILXTcvnQ59YODo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qaobnzj5+j3kY5Oy+ZWx5DsIKHmyK7CbJM8xmD7ptkDoHEXXZpjxgfmJMkp789u7cgRpXH77I3RfAsn3MmdKxwvUTiXYO4QLbWqfBiT+ruK61A1yWk7H0z//34tH9jzwch5Kgc2KWVpFwnnUMJRxVQsLx/YbHPcJkvyqNBsa4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3/zv0Ib; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3/zv0Ib"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso3967172a12.0
        for <damon@lists.linux.dev>; Fri, 20 Jun 2025 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750456058; x=1751060858; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/b8SGEJQFlDd4fd5rMq8B6RnUjovzraV/pGDKTi6mA=;
        b=l3/zv0IbZuXKvo7P5HHx2IbjzLMbmoVFlDrp57i3DpnVBuZtDAFYc+z/SzZwTiY7z2
         5aELMAbHFGLtoijR4VwZzR17L9Lb0FkWwVnIBAD3CkESsJBrKeb+ihMc1KDI5tX7o1Q2
         n7klRCKzKXS8keQWxq7klRuOZ2L1RKV7/uuKDxj4t7BylYkrjW+ymAgrXZY1eJAjNYh7
         x5y7p+VTl4A9qaaVlvqMrR/oeuVYeoMdcY7BpQwh/kXhsESHAu8ICgmeFTAXrpK3ayz2
         Gccb/rcy50KsbiPAgqxCuWPwL9n3NGAbJ2gk2A52XJrmS8/QzKIEqwvGVP7yOUIz++pH
         AlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750456058; x=1751060858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/b8SGEJQFlDd4fd5rMq8B6RnUjovzraV/pGDKTi6mA=;
        b=v+p7lqQOKQ6Y/vOIzT8zdMwQtC2mC1Lm5qVgODEKkcU2i3liiXIJcFqG5/2p7d6d6X
         x37N8FSkDy5mcLWdMSJ/UCdGZ/YO8o2zhWMR5xjAZAsU/uEWrZGZdLM5FLH+wzlNlen6
         bW6IA2zcGrbya9dU41gnaSvVUpnPMgRzisZmXhgVM1l6PwAn4lO5Pa/j6WrrU8Urf0wa
         i4Z2dpLypUGTh5pXXQEjQqXDDkadQeKsNzQ8LG6I6zdjrIT+KXseLIXrQAIm+tT7bRUx
         44DRFLOCAzlI71SScrMiC9LMhZ6Ena92m8oXnKsVtZDVRx4Ttx/wQewrIwxxlEFAclB7
         7Rkw==
X-Gm-Message-State: AOJu0YzwCrzg9stUueRDGEFq/4+XT3PSuStsGrb0c9adbpLe9etz1bJQ
	sve9PCOI8sr/G8Nz9vvatjMj/F9nqy/fd1a94YHIeZGjlR0yPABtcYCJb4O6xCPBjqBG9qROb3R
	brXVpM4c/28hjMQVBaN4F39Si/VXreG0=
X-Gm-Gg: ASbGncvhXPHIajwCeQ+jZ+CgeovfGFfBR/AIntSpoP6Fw+68fwEJUGjFmPmEIxFtEM+
	Cn2g76IEaFE7HRD2mGOPCozpPa5kGZ1+hj1BY9VkvU0zFmPl18QllZ1LdxX8cDudNdVp9Nu5sUo
	5sZuQNDKvSc0EFwrR53DDqlrLUcl/7MVTlho4nl/uqwpOHUNzGs7CAACxN508/Vpoy0+vJ993Lm
	drE2rUnpBM95rNg
X-Google-Smtp-Source: AGHT+IFBMnvlkmoY7H6omzg7UDAqSYXQfxSICjnkdbKgo7nV5h7TFBh+q5W8gVbHtCvl4GGytB5w6tjyIEcHnyR3jsA=
X-Received: by 2002:a17:907:7289:b0:add:f191:d851 with SMTP id
 a640c23a62f3a-ae057b60511mr397434566b.32.1750456057834; Fri, 20 Jun 2025
 14:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250620180458.5041-1-bijan311@gmail.com> <20250620202155.98021-1-sj@kernel.org>
In-Reply-To: <20250620202155.98021-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Fri, 20 Jun 2025 16:47:26 -0500
X-Gm-Features: AX0GCFswQvDPvHTlBd2hX3fSa1Acsc4GALQizBGHTv_3IJ0fB0gZkfA3pdqdjFg
Message-ID: <CAMvvPS4imbSprPPZ3dtPBK2i3DZPffYn3d4rASMoNwcTeHCWqg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in
 migrate_{hot,cold} actions
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae,

On Fri, Jun 20, 2025 at 3:21=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Bijan,
>
> On Fri, 20 Jun 2025 13:04:56 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> [...]
> > As a toy example, imagine some application that uses 75% of the local
> > bandwidth. Assuming sufficient capacity, when running alone, we want to
> > keep that application's data in local memory. However, if a second
> > instance of that application begins, using the same amount of bandwidth=
,
> > it would be best to interleave the data of both processes to alleviate =
the
> > bandwidth pressure from the local node. Likewise, when one of the proce=
sses
> > ends, the data should be moves back to local memory.
> >
> > We imagine there would be a userspace application that would monitor sy=
stem
> > performance characteristics, such as bandwidth utilization or memory ac=
cess
> > latency, and uses that information to tune the interleave weights. Othe=
rs
> > seem to have come to a similar conclusion in previous discussions [3].
> > We are currently working on a userspace program that does this, but it =
is
> > not quite ready to be published yet.
>
> So, at least in this toy example, we have user-space control.  Then, I th=
ink we
> could decouple DAMON and weighted interleaving, and ask the usr-space too=
l to
> be the connection between those.  That is, extend DAMOS_MIGRATE_{HOT,COLD=
} to
> let users specify migration target nodes and their weights.  And ask the
> user-space tool to periodically read weighted interleaving parameters tha=
t
> could be auto-tuned, and update DAMOS_MIGRATE_{HOT,COLD} parameters
> accordingly.  Actually the user-space tool on this example is making the
> weights by itself, so this should be easy work to do?
>
> Also, even for general use case, I think such user-space intervention is =
not
> too much request.  Please let me know if I'm wrong.

You are correct. The userspace tool would be coming up with the
weights, so it would not be hard for it to write those weights to two
places. I coupled the weights used in DAMON and weighted interleaving
for this revision and the previous because I could not think of a use
case where you would want to use different weights for allocation time
and migration, so it felt silly to have two different places with the
same data. However, I don't feel too strongly about this, so I'm
willing to defer to your judgement.

Also, our userspace tool updates these weights somewhat frequently,
several times per minute, when it detects a change in the bandwidth
utilization of the system to calibrate the interleave ratio. I am
concerned about how frequent changes to the scheme via the sysfs
interface will affect the effectiveness of DAMON's page sampling. From
what I understand, updates to the sysfs aren't saved until the user
writes to some sysfs file to commit them, then the damon context is
recreated from scratch. Would this throw away all the previous
sampling work done and work splitting and merging regions? I am not
super familiar with how the sysfs interface interacts with the rest of
the system, so this concern might be entirely unfounded, but I would
appreciate some clarification here.

[...]
> >
> > Questions for Reviewers
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Are you happy with the changes to the DAMON sysfs interface?
>
> I'm happy with it for RFC level implementation.  And in my opinion, you n=
ow
> proved this is a good idea.  For next steps toward mainline landing, I'd =
like
> to suggest below interface change.
>
> Let's allow users specify DAMOS_MIGRATE_{HOT,COLD} target nodes and weigh=
ts
> using only DAMON interface.  And let the user-space tool do the synchroni=
zation
> with weighted interleaving or other required works.
>
> This may require writing not small amount of code, especially for DAMON s=
ysfs
> interface.  I think it is doable, though.  If you don't mind, I'd like to
> quickly make a prototype and share with you.
>
> What do you think?

That sounds good to me! Having a prototype from you for the sysfs
interface would certainly be helpful, but if you're busy, I can take a
pass at it as well.

> > 2. Setting an interleave weight to 0 is currently not allowed. This mak=
es
> >    sense when the weights are only used for allocation. Does it make se=
nse
> >    to allow 0 weights now?
>
> I have no opinion, and would like to let mempolicy folks make voices.  Bu=
t if
> we go on the decoupling approach as I suggested above, we can do this
> discussion in a separate thread :)
>
> [...]
> > Revision History
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Changes from v1
> > (https://lore.kernel.org/linux-mm/20250612181330.31236-1-bijan311@gmail=
.com/)
> > - Reuse migrate_{hot,cold} actions instead of creating a new action
> > - Remove vaddr implementation
> > - Remove most of the use of mempolicy, instead duplicate the interleave
> >   logic and access interleave weights directly
> > - Write more about the use case in the cover letter
> > - Write about why DAMON was used for this in the cover letter
> > - Add correctness test to the cover letter
> > - Add performance test
>
> Again, thank you for revisioning.  Please bear in mind with me at next st=
eps.
> I believe this work is very promising.

Thank you for your help and feedback!
Bijan

[...]
