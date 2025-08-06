Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3DC3FC7
	for <damon@lists.linux.dev>; Wed,  6 Aug 2025 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451895; cv=none; b=PK9is8rCWA04VT5CiLUT6CJ5XchTGO0jO+GhhXG3e8eA3kT+vDAzLINtRhZsz2SOmnsnUSJ/KZAP7asxW3yAUA/ma8xkTeKHsd+TfXZE6y0SfMMYy86EEfIJLxzhBX80uyYhvA8zEAHgzSo/xmD9P5VbnIvHu/ZHn+JHUnBBguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451895; c=relaxed/simple;
	bh=aETKIt2AgsG2H1/2Wh/PuDKtIAaiStlXPE75LIW7C7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rlq8lPDkIbOTC+Gs4S6vlg8Dib3tKsl9IuHBq5ya3vwVVuiOl4pgHsPOwpBY3WTn8Gk/qf3sN5RXtb58SJHC7gyfxYBI0OS+/WuHJOjd6UBX2Bby4ZzSwZz2RZ6eq33kMIOYJILblbmUGQLEMe4Bj1iUP9N5xPWawXcM4CFT9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2nE8t2+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2nE8t2+"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-301a83477e5so5268532fac.1
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 20:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754451893; x=1755056693; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aETKIt2AgsG2H1/2Wh/PuDKtIAaiStlXPE75LIW7C7s=;
        b=N2nE8t2+Cuark+Lhr8kCCxSMY54kY4OsAoj+cs7dRs1wMPZTE28Bb0j29Km9VV3OG1
         OMfjYTTqK0bg3KTziIjwCEVmhRJL1xvj7ON9KS+SqnAwMg+4DpfoiHu5uPq6cPGG7V25
         4Hc/NidjmF2d4J0bs+ErAu4zBg0qnPXOMHF9qd/T/xuEh9McibtzzGs6lUR0kpZSyrB3
         zBpioLKTK9TEOYob9FSHVIue62B/fsDLI7HYW1zmVCx+Toyi5tQ+8AraPKA18I0m0GYz
         jNV52aGCcvRuOkuUrD0svr1FBB0L8XWEr6+mEIbfjY7fqog9vod7ZFOmfh4n7OvpHSmO
         wjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754451893; x=1755056693;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aETKIt2AgsG2H1/2Wh/PuDKtIAaiStlXPE75LIW7C7s=;
        b=moXLCse1OcrXJ3uB1QSnwdcp8DGDDXbrgDU/uthihXCm4Zb6/HHRM3hsNPOV04Rnds
         pR67uVgBEex2zkZesDev2pgGmuRyh2DadqJ/rQqBcYSNef9q7pgUHGFi8AACEV7nnYeJ
         bu1f4HxWRdqGfgFd0GRbzGjv9MRqJOVKgcjS2ZzSyaxYjEEHkmLK0w1gH/fpBt2oLvPE
         K5Tc2fkS5edmvKAxdKrTB/hQUG/OFWEEkUZsoVMtIMHqwduDqfJ2Vb/X9FYGyqTa5v8i
         iLAU1hWB7C7SuAeG8VglwPiz2KtqL5M5k7hDEmuHrWEZqJGN+DjDSTFbpflvJWgs6/jS
         3Nrg==
X-Gm-Message-State: AOJu0Yy30rqBZd8rKyA1I0cj9p/zubG5yO+vKOosX6PD1hLotFNdqF3t
	Nmgpfi63onIeG2bLfAdRaeDia72nQpjI9hi9XEf3SvGCpBEYnk82TDE7yhsScPkxONlg4qowo2j
	j2yvxZTtDo2T8FPwy87XDCjJr9hMpG0dV/QAizKg=
X-Gm-Gg: ASbGncs0Fj7dbn++t5bwZtcBK0pT60qgbj9lzTcGs0SSbuY+bExdMy6R3RMsvwynOn6
	8Vbs0WokjRTkYFpS3zrlaIN3PHpgBMe5jO5+VLZJ2s9n1/tpAMEAdFENXGkXCzxMAzcV0EAr8kX
	C7VWn46HWJRbyAe/kxOesMXeCvqh+hRKMqBAza6WF33f/Ns3lEB4eYN+d6XpWFBPyxxk7Qu8FnH
	6Lq
X-Google-Smtp-Source: AGHT+IFwT/F+vr5A7vvDRtBqjH2Ue1vFzrn5DgiviUK68HWeVT2ubMGKgcR4oAY8kPeDGxu7GuzubqLKpVCcJaOmhbE=
X-Received: by 2002:a05:6870:819d:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-30be2bf0746mr907629fac.25.1754451891959; Tue, 05 Aug 2025
 20:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxMFuqUbZ3fwOmZ1O42cicrBxa1s39w034W3W6ZnYmOu7kg@mail.gmail.com>
In-Reply-To: <CABFDxMFuqUbZ3fwOmZ1O42cicrBxa1s39w034W3W6ZnYmOu7kg@mail.gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 6 Aug 2025 12:44:41 +0900
X-Gm-Features: Ac12FXxEwlLiOt4u_PPvIQnUz8L3Wa2x3w1FkLDbjBgvAvWrRpb3nZt3IIbN_Ho
Message-ID: <CABFDxMF44rSF=t1k3K+TzjrKzC5zQW+bFvx=u90g4ttz21i=Hw@mail.gmail.com>
Subject: Re:
To: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because of my lack of knowledge, the above mail is just a mistake.
Just Ignore plz.
Sorry for being annoying.

PS) Unfortunately, I found this thread [1] after I sent unnecessary
mail to others.

[1] https://lore.kernel.org/damon/20240926213942.17022-1-sj@kernel.org/

On Wed, Aug 6, 2025 at 12:34=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> subscribe damon mailing list
