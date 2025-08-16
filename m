Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D331E487
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307107; cv=none; b=jwzvZwhyYKjXLzsktO9TRS0tZAjY19TXWH1m2S+GaCexEcMgFPt3SMYRMJX39JNjCHVHwBALhWWEmYIMTkwk1wTpdQbls/wXobQwk2GAhlqRDvgeDyKj7snlGLc7gpGSoYrqUyeSaDI+pWfznk7DYo8OCXS8SWY1xir8Ko/xDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307107; c=relaxed/simple;
	bh=webZLS8x9LTuKsVD+p4et5yOLXcg/n54voslo2kJl60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZ3MVJyWLdqEEIQ3at75pr/I6t8FxZsbzzMQntTKCt7D40rlbz/1/hwZ+Glg2h2Wx4nWX2Jog5AxB/olnzCDgwqxFijIWFLTNXiTEdbkCgR4bPb5nAjcg3hLZvVz/m9ohIM/WvipWoXsGbls6tyj4wnWU1PJqOksfOj8qTOVC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRDLTIjG; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRDLTIjG"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cce923bc2so1245847fac.1
        for <damon@lists.linux.dev>; Fri, 15 Aug 2025 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755307105; x=1755911905; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i85A295astkrnsG0olPQxO94kGINVJjCYBUtAM86un0=;
        b=WRDLTIjGlOX/A12B6GO8zflXUFgra14YoZEIr0m6EW/QRQytj5aksls1DzZlyyX1Vb
         /mV+UcF4ff1pj478beWflFgcg+4/iyq1nElBCj6OL2s3MkQnGyZW4P4PjjixL1AslCQ8
         SCKk25wPSddtnpt05n1KMBXD+TD5kM90/Jqkx6ytAPZYNujgVruIKoEHtM/geDocn+Gw
         mvkszFmWW+kXR4N1dOLXyU0wlLcgEwmoWFfH0jzw8suMmqOmdVYgEQzdB+wEwjxdW8rA
         hXt7pLOYCJo/1HqXYEGGG+/hSOwVfHnqBWuibwwfoDstVyurKSNUi9m9X8dWoj7cCec8
         6POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755307105; x=1755911905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i85A295astkrnsG0olPQxO94kGINVJjCYBUtAM86un0=;
        b=OCPMfEe1nVogvYmMSktMD/nR6ehA41oErK5tOPdKPElxH7P/VgRuBfw7ygUQDfyerM
         /bI4/QDPPZSjkEzqnVWsLKVZ7ZFfy2n8mSClI+n6baP3L9DgGPuKZnpKi8HDAHHdDhtC
         4gskGMZWVbG3EcCWQuPI9v3FbnoFeNjqs+W3nfD3DVyYeGfYHYpAridNEeVMR2F1Ntlc
         LQGmCICM+f7Q/jZMIL/NPXaETi9NsDhDnnY7OPEttS8beKgKmeHJch5yffZMSNBG4I0A
         C2pKB0cWj2gA8RinAfbjJzDkLUtKO7m0uzvsXJqitjYMOZSjo67TPk2sQy/VduoySb/L
         MLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv4qie4kCc8PW9F/8oYD9CU9nc3CBulaks6uiwOror1yZXAQVcPCKagfLAs2pCYi34AWGI6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMoKaEP4zRNk2sBMLXl118YhSiMTALFKG59qFkFcHtabUAwSjz
	U9k/yn1FzuVrD5GPpFUWeonL7U+phpgf8qv8UoOpM/aeRWZ4aMLYcu74p2YUUqR+I1cT7iEe2dt
	p0IstfuaY1AZFN7qQCExyu+5JibjTJkE=
X-Gm-Gg: ASbGncsTDy2rQCaf4oEQh47p+25vnc7B0EoSi6QXabgRYb0w3YsgpF0k49W6dXfffg7
	mfcCAo/gXpZHrCPUEfwRui8LTk3nmncQnL22f52M+C/Dq8k/C6KP4Ej0jcKuAiNsj20k5ikRaAE
	ZkCtZqPyYE6kPzIRvlFojU1DowsBIbBBiug95vIf+1+7wvmKT3obf6b11rJgaG5ZpJrhqlAJpJK
	CO4i8HA+/QQNig=
X-Google-Smtp-Source: AGHT+IFqT2oSNVenN+f4QBQCYTnTPaAAwiOulHgCDn55IB+cL8UJfXfdAdPuWYb6zvlfD5igRmVjFo5PjCQutnnxHLU=
X-Received: by 2002:a05:6870:bb12:b0:301:1218:60a0 with SMTP id
 586e51a60fabf-310aaffb0bbmr2472700fac.34.1755307104988; Fri, 15 Aug 2025
 18:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250815094059.133769-1-ekffu200098@gmail.com> <20250815172545.16704-1-sj@kernel.org>
In-Reply-To: <20250815172545.16704-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 16 Aug 2025 10:18:13 +0900
X-Gm-Features: Ac12FXzKzp0T7fzOIpiV_MJ8ZJ6of-v-S2DlMbu45VJeqoAZcVxgwHGqVvqyj3c
Message-ID: <CABFDxMG2Mr+zO6i7a2_J5S5j7+4etiQYFur=0a+U3oNOS8TMMA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: fix damos_commit_filter not changing allow
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stablee@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae

On Sat, Aug 16, 2025 at 2:25=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Fri, 15 Aug 2025 18:40:59 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Current damos_commit_filter() not persist allow value of filter. As a
> > result, changing allow value of filter and commit doesn't change
> > allow value.
> >
> > Add the missing allow value update, so commit filter now persist changi=
ng
> > allow value well.
>
> Thank you for finding and fixing this!
>
> >
> > Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit fun=
ction")
>
> At the time of the commit, damos_filter->allow didn't exist.  I think bel=
ow is
> more correct.
>
> Fixes: fe6d7fdd6249 ("mm/damon/core: add damos_filter->allow field")

I found a wrong commit, I'll fix them.

> Also,
>
> Cc: stablee@vger.kernel.org # 6.14.x

I'll also add them.

> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > While fixing kselftest, I found another bug and succeeded in
> > reproducing. I think this patch is similar with previeous patch [1].
> > Also instead of sending patch with test, should we check which is bette=
r:
> > a seperate patch or patchset?
>
> Separate patches are better for me.
>
> I'm not sure how you will make the test, but I'd usggest making the test =
as a
> kunit test.
> Please refer to mm/damon/tets/core-kunit.h file.

I made kselftest with drgn, but I think that kunit could be a solution as w=
ell.
Honestly, I haven't used kunit test before, so i need to look into of
that. Please just wait a little bit.

>
> Thanks,
> SJ
>
> [...]

Best Regards
Sang-Heon Jeon
