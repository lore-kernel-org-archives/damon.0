Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870582C60
	for <damon@lists.linux.dev>; Mon, 16 Jun 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112191; cv=none; b=JBV+mjp7AoFyDUSLYYeFbxDIOCklZr1nJRiKwjWx4WH1QxUtwpfXkrS4/UeU+8VOhSIYDLMkGQPyslsnqwpNOzFWzpfdWx20GpuR1Sqqg+cgvKIhZb05TZFF/Q3QwQs3iE1ASN737RH9aCOFuP8486xTCm7Gm45lhPLl4zXobTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112191; c=relaxed/simple;
	bh=ziUc4Cazu8rPOj/A9CHLv5pVaJlPgsivV34HGY6F5Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WK0fbT723XGw9mubr6UmbuM3C4HUCJ2u7Wzi//+5PrGbDAzKsqLySmpNlmvY97Op+xQoxJxgUwTmLItni+HgA6W3LRT0B8vVT7koMTyZrbY63U+tzuyfkBcxfwHFpJGm7+m5QloouPI89x7FMpDmXtKmJjKXYKCr33lzutFAZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxc+ZmJP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxc+ZmJP"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-addda47ebeaso1012230966b.1
        for <damon@lists.linux.dev>; Mon, 16 Jun 2025 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750112188; x=1750716988; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4x/p8NEu399tKFp+L82OEsMeF0ul8epvOoGorBxox8=;
        b=Zxc+ZmJP+Fj5a0sK3bbsRjT4OE5YXg675prN/+CwwPoDCY440QOecblqzc4DMcIFQE
         VcMMCZoQDsaH0xPhvqpYrYTEcAmMchEvvel3N0N2dupoyQl5u1PK/5LFFRtK6rzfKEqN
         knEQn/D9H+9OgvTqRL2k89nAWAattNMJXwer4DH8KCNA3BkIyppD6XHtfJdD47/tFNP6
         Pe4pIrzLdXXa+L2D4nYjPVooqZsyQF2lJVQNl5a0EEkOm5JIg55/K6BVDVr1+C6mm/4a
         0khU9c9xPDjL9N5iMlQIBlqfwE+dKDQI2urfOPOR6YyUJiLK6my1BbrwdXIUqCnewSDg
         PIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750112188; x=1750716988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4x/p8NEu399tKFp+L82OEsMeF0ul8epvOoGorBxox8=;
        b=Rn8uZuCJENFS5ylp1MWhrUfBIc87SEBxr1CdqFyFC7EFMHjv+IwQd5jZj7kYTbTDrS
         8KnQIGMNO+oGeKb1IleedNqLxADQu/Gq2gioFAHlnFnYCpdk8zjewHR8ATJeqyYYb++Y
         v1ITno7YStM2MEQRQjAwSey3IQvrz8dsZmmoVciTYZCDpoiqjB+3h//m0fuff+VX692l
         hBAr5H3jzJnNv+WlzrqvCT8sd6/84FAwPkanuujZBPsbDrKFBp3UJ9QdV7zKrfA8z3xb
         Tvr7hyeifQr0EcLmcTCF5Pd0uaZglUX4DCOfhu5vvRDKffwr+Zn8BRF7HrzuUkS7YW6n
         OvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgmZ2dD9j54MlKpC1F6cOYVwbo0OXubZ0JK9/NOZZfkzuxzxmY+NlzrN93PcMiDvemlNCGAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzofj3bj4xRHQeaoKgNVKdI+c75T7NuBOSXbl8UBdpV/iQQOHzo
	VbNtJCgM9eUjcLu4ti/MO9Jkd6pcchyMAcCUVcDq3KdEWARus9K3wUALB5JjIlHFKulFOCRE9mW
	bCQUTe2SlgI9nT1wFY4X79ZQr/QlZFi0=
X-Gm-Gg: ASbGncuqQPm4GL2wXgTUn2wZAkD8aBgGa/aM2DC93xIUlzQfK3eTJkil55tpjsBPk7O
	RQ3pLqlOaNfS7SUOBnRwMsyR3HvWgPARNhQWGW3CRNLSLtRNkJwHjspMp9RP8O/EXFwPsTns6Mj
	/OJU4S264cDOsFPfbzA1isNq6OMc5yjTMYRFgp6umsTGwIcF+ANnDFFc/gHwl1R8USvQFNpKQcW
	nWWow==
X-Google-Smtp-Source: AGHT+IHWhKGzFlw/YafR+gXhZspwtYe6gkGuL7wwEgT/ACXbIUqtoGIZWUoj26D8y8Znb1z69yrl5bOG+d7vxjTvsJ4=
X-Received: by 2002:a17:907:608b:b0:ade:3bec:ea29 with SMTP id
 a640c23a62f3a-adfad397276mr976447066b.25.1750112187830; Mon, 16 Jun 2025
 15:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612181330.31236-1-bijan311@gmail.com> <20250612181330.31236-2-bijan311@gmail.com>
 <5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com> <CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
 <e40aa590-f0a2-4666-84b0-c33c8f4fef87@redhat.com> <CAMvvPS5bTUfAXy4g79tAq+1DWKX79b33Jt=UNBg-xR9BDa7FdA@mail.gmail.com>
 <aFBXuTtwhAV7BHeY@gourry-fedora-PF4VCD3F>
In-Reply-To: <aFBXuTtwhAV7BHeY@gourry-fedora-PF4VCD3F>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 16 Jun 2025 17:16:16 -0500
X-Gm-Features: AX0GCFtwj_QtqJXZ5jL7Wr8rfNEzrgEzB0jYXSU_0HLJ7kNaT0LSOgSWCHGca98
Message-ID: <CAMvvPS4aiyA7nXTN=QkMz4ikvf77ZaZ05ys-4N09AFLrgeS_Pw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in include/linux/mempolicy.h
To: Gregory Price <gourry@gourry.net>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj@kernel.org, akpm@linux-foundation.org, 
	corbet@lwn.net, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, bijantabatab@micron.com, 
	venkataravis@micron.com, emirakhur@micron.com, ajayjoshi@micron.com, 
	vtavarespetr@micron.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gregory,

On Mon, Jun 16, 2025 at 12:43=E2=80=AFPM Gregory Price <gourry@gourry.net> =
wrote:
>
> On Mon, Jun 16, 2025 at 09:16:55AM -0500, Bijan Tabatabai wrote:
> > >
> > > Which, you also have during the rmap walk.
> >
> > There is another subtle dependency in get_vma_policy.
> > It first checks if a VMA policy exists, and if it doesn't, it uses the
> > task policy of the current task, which doesn't make sense when called
> > by a kdamond thread.
> >
> > However, I don't think this will change what seems to be our consensus
> > of adding a new helper function.
> >
>
> Hate to interject here, but this gets worse the further you dig in.  The
> mempolicy interface as a whole has many, many, many hidden references to
> current->mempolicy and current->mems_allowed.  External interface
> references to a task or vma mempolicy is a problem i explored somewhat
> extensively when I prototyped `set_mempolicy2()`. It did not go well.
>
> Generally, mempolicy is not well structured to allow external actors on
> a task's mempolicy.  Accessing a task's mempolicy requires operating in
> a task's context or at least taking a reference on that task's mempolicy
> (which requires taking the task_struct lock).

Good point, I didn't take the lock in the second patch. Also, this
made me realize I need to make sure there isn't a race condition where
a task exits after getting a pointer to its task_struct from
mm->owner.

> I will just say that mempolicy is *extremely* current-task centric - and
> very much allocation-time centric (i.e. the internal workings don't
> really want to consider migration all that much).  You'll probably find
> that this project requires rethinking mempolicy's external interfaces in
> general (which is sorely needed anyway).
>
> I think this path to modifying mempolicy to support DAMON is a bit
> ambitious for where mempolicy is at the moment. You may be better off
> duplicating the interleave-weight logic and making some helper functions
> to get the weight data, and then coming back around to generalize it
> later.

This may be true, but I think I will be able to avoid a lot of this
nastiness with what I need. I am going to try with the mempolicy
approach for the next revision, but if I get too much resistance, I
will probably switch to this approach.

Thanks,
Bijan
