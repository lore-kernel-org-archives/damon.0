Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845DA213E94
	for <damon@lists.linux.dev>; Mon, 16 Jun 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750086134; cv=none; b=YujHY4CItnNK+dOoJcsOL2TnNL9HAIoEUkXCb+aon9SB0Gn92hP0yAPZS0q5eIps0CfBW6VS6nIinZHXjsk1vHLyKv8tYpLjRvj7yQ/opdILuhTWz4sVnwotDgEFuxzib/KRWNx2V3kX69iUxbusJlbw98hhT7QlpyKOWAL/lCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750086134; c=relaxed/simple;
	bh=5FGZTXPSRB9UdOMKVVzsofQp4QdGIsgXthBaH70tIlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UheCqau8eUaJtbVzJm+dln2hM6Iz6hbn3npbRnqAC6jtHC7Anvq+TvHU2a15W+0WaTT84FgP22dJKveh0pzR19nKoO+pMFY8CggamBWKVPIb/AhIpxKNVP9cKO3CFXxEko9bY0rD2Dv+bfSQMPimQreg3+nAbX//91DeRbBPkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvS8EEFv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvS8EEFv"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade33027bcfso741650066b.1
        for <damon@lists.linux.dev>; Mon, 16 Jun 2025 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750086131; x=1750690931; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxpfP09wMONaS9jpAWxQ7WCauQRBx9+f7EU0xvtD+hk=;
        b=WvS8EEFv1GVSUsEJyw6RPk/+bLHBfncOyRH1fN+Qhz7jSmO1sOD+QPe0c8UsefTfCI
         3S5vwe3lT4uwc4R36YgBRgrnk54LC9MaUH9MsuXzRJvqYva1P+5ECt/Rf59/7vxBzVR1
         9cKOvDw4IcURg9C9ANW41X8yl8Yus2x0zdsZC5VUTKWc05AmRhu73UrqdJrENMr7NVH8
         01FHUrpLtcUrO1N5S9tPtEwsakfhOSiYPZwkaOy8QnWtO65tkden+cMuJnsTC9HiywCG
         l8m8CVr2l1IY01BGLFDtRZCGemrJ/61ZT1Wzl8hqMtOIYBdlP/PYQ21/ZE6OFvUgsxFx
         GiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750086131; x=1750690931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxpfP09wMONaS9jpAWxQ7WCauQRBx9+f7EU0xvtD+hk=;
        b=tkKqskgEtx8QCuExNK2t7D/Wyr14l3Ju5zB4I4B94AsuU4mm7HVnHqfFgwFRoDcMz4
         azz+rMnR/3KVQPauirS6lR9EjM1oE02KQu34BuRJyzbt1Fcy9pPxN4H3zULx2GSqOpV5
         aPLKb8FC1S8Gt1gkG79ujXcrzYw1yUig3KFQZYHwYvtR9aXkV7R8irL1XU6FFk2WzGpp
         +eCZP2vlOd40MC5ntXlxhT9LX/tsBfo+RwV6N4VQWwMF6CzhfnrDug49I3ZrJWU6gxt2
         qlv6A5DjeiXqB04ZmLkW9lOFzqIhi6dXpC3s8lThyKQsyDVFkwoFeezYh9LbfGGiNCAH
         wPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2rpNtqTNbgWmjnfezspYEPHF52CInLVGesp9eNohBlB/KpWQNJjYfSQJXFadcfQPa6HIBPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGQ8Nxn4O3G5jTQsh2a7zSnLpze6QMLjtLGA8c7ia37am5sXyC
	dBLS5/D6VegjEW7WcOaZk8dtb2BTMnoTmt5nDPAmnTVv00G9ZqVpSdCjszsWrPvmiGzlIIy9iIq
	ezC0cFWhh3SfRVaaccdiF3ltwMUU0wic=
X-Gm-Gg: ASbGncvb9D+Y678Wb8b+Yfufl/hPVRu8UaJ3dp6V7Xpea4cOMBfI+BjffWG7zM/I0/S
	AOSRMjsgaRZXk5JR0SmHDR+q2ASDaOyfug9W1VnAErj7KknPw+tzC+NjJNNgWOF8Rmg4oet1Bk9
	PsZ5OnQirOG+qo9cRH4P0tdmJ2h8oaJmq/6ZweOFpDBJRGJmyQj9bs1m1Oj6Zbb7TFImm4YG2ND
	vzk
X-Google-Smtp-Source: AGHT+IGJ/zFE4w+JKMjUWfvDesBnew2u7pOoc4H3+qqMTkNhD/5NjNC8e3RLUAEQRY/PUbER+yrMW04GTUY04EM7Ez0=
X-Received: by 2002:a17:907:6d28:b0:ade:2e4b:50db with SMTP id
 a640c23a62f3a-adfad2a0920mr927784766b.10.1750086130484; Mon, 16 Jun 2025
 08:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612181330.31236-1-bijan311@gmail.com> <20250612234942.3612-1-sj@kernel.org>
 <CAMvvPS4WsGkfukNscnLWW40Agg6_wmkm_QF96m+HZrEZrstR4A@mail.gmail.com> <20250616074233.GA74466@system.software.com>
In-Reply-To: <20250616074233.GA74466@system.software.com>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 16 Jun 2025 10:01:57 -0500
X-Gm-Features: AX0GCFv72kKkxX-qe1l08YvlwPCsH3UbKfNEIk9xWqIa4M8jORlTYRaH3Xzfz5g
Message-ID: <CAMvvPS4OAHAdUJtuinCgo+oTQ8akSk8138LikLx_38pr8rtqeA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: Add DAMOS action to interleave data
 across nodes
To: Byungchul Park <byungchul@sk.com>
Cc: SeongJae Park <sj@kernel.org>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	david@redhat.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, bijantabatab@micron.com, 
	venkataravis@micron.com, emirakhur@micron.com, ajayjoshi@micron.com, 
	vtavarespetr@micron.com, damon@lists.linux.dev, kernel_team@skhynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:42=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
[...]

Hi Byungchul,

> Your approach sounds interesting.
>
> IIUC, the approach can be intergrated with the existing numa hinting
> mechanism as well, so as to perform weighted interleaving migration for
> promotion, which may result in suppressing the migration anyway tho, in
> MPOL_WEIGHTED_INTERLEAVE set.
>
> Do you have plan for the that too?

I do not currently have plans to support that, but this approach could
be used there as well.

> Plus, it'd be the best if you share the improvement result rather than
> the placement data.

Sure, I could add some performance data in the cover letter of the
next revision.

>         Byungchul
>
[...]

Thanks,
Bijan
