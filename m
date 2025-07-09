Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E62E8DFA
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070051; cv=none; b=aK67Qm43V0z73YIit2TAOY29JQ41XUfDfvxGsSir9Iahmu7H8xDphdkdMTlWga5I1zZ4hTME3hfb5WO+15kDwiFb6ti3xS9KKOrOLORBOO/wZGEXz4iM9ED3cUHJw/TikVOIhzxUdBiaMozxV8r7I1cMUDuUcFIGeitFPnE5eYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070051; c=relaxed/simple;
	bh=0vIhpx+0YQQm1MaG38coKriz3Hl7RX4m9tfVDq7x9mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt9WtKiyDtkq6CGBC5DDkwIr05n9xRuYvuszp+4PTc3/FkfRH0+oXTCKvUpWh/h7TDWAtSeqqdJw/KTwz8JT9rbli9lodunOvZn2qJA8vMYWYskwUPd0pbiSiKna9RW5gsVrmHSVHWFsj+HtPWApCPLYrzRfSQNGErzDyvOeUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2vwEWsN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2vwEWsN"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0c571f137so1085177266b.0
        for <damon@lists.linux.dev>; Wed, 09 Jul 2025 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752070048; x=1752674848; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkAhtJII7qepeyVa2+QSjE/0dSe9MXuvFykrrDGX/LE=;
        b=S2vwEWsNUkio1DWmNvhfusKChcFpV9n7cx2CBZVt0lN452n9guRspoob6wBxHORDu6
         XfEZ9Tx4GeRp20B3W84dvPmDkIpUaahGJn3AYBsaVL0C0OAKrVRVOYvkXRVNlC3lbClT
         gp8ejFpvkuCBg0uOtYWX+W8y71/2zqWrFr7qO4E1pKvEwUzaVetBhj7BpdtWJy0VV9/v
         7V35IckfSli0sf26GM553HM9w3uX0Dqvckk/etjGvhuXmn/QeFg1BFDfRero6z5gd8cK
         F8BpGUaxubGSZMn6vU9HeXQXGpvJUPBEn9UqlP8TctljKSD/9pr4BO/F/anBgz8PfKMV
         SYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070048; x=1752674848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkAhtJII7qepeyVa2+QSjE/0dSe9MXuvFykrrDGX/LE=;
        b=hm57TdXP3oeGUl2Za0M6QP7I70nb0ofnPo851JUqJ+fRokLTaLEJTUccNqNEthLu/h
         p8Dmnmoth+ks9ZP/MfWIqEymegVOM/me/zuXzRvc0RKSlKdzb7H21Ui3TF3naCAuCH17
         aKdnpM+/M+cal4g5wczrn8icwPJI0GEf5R9eZlAJ94U3BDH5JwQzQmoMLDYPnJj9OsUc
         M55Yr79LBMtE2klCsXqB9bibVQBdkXYMZxVXBTs+u0Wqfir5QcxMNl1zS/Be3O8RSPix
         wmW7P2JhYFEJXQySIe34JAd7Ujn4ia4a2f0d4Xkw5UufieSv3XqM5tjJ/cWNXAl1jP+h
         88+Q==
X-Gm-Message-State: AOJu0YzwzmB2k5EBK3582fo6QCzK1wp8hU++KkFfHaMWDqZXntv0HRVA
	O1Zfh3zycLpu+x/FdlW6SYAIfjYUhtetM4GhAGbvJtYv2wzM2jg6f64ETUnjYGGDyiaN50+2QVg
	dYH46XC6m7hO3pvYLf8ikV3sjy20Vrsc=
X-Gm-Gg: ASbGncu/t2c8HZBbHzhsfCtClRHIYkX335EXyTIDy1DL5RqrvK2KgCGh2PUrxAn7VcU
	r4qRThQA6SOGjfE5w687rWBSrqfbuBEGaL3HxAXUFuAYNwJKfy4uFr+gM5FHAmAp0N931tcLrnb
	nOo6VZJh7mGfuxeopSyxS9ECfgKhon64vTskgp12LcTJKh5kEcTimSYNVgR+c01pGhg1y8V60VJ
	z2yokL4rfwUODap
X-Google-Smtp-Source: AGHT+IGIfSNs28NtfUwdB7/Q+GAf+1HaldJgehEtx6rpKFjG5kyBclCrpaomz4JmoRY5EzJIVVBaqimr1SPayzymfUk=
X-Received: by 2002:a17:907:7f8f:b0:ae1:5db8:b78f with SMTP id
 a640c23a62f3a-ae6cf7354a1mr263493666b.34.1752070047664; Wed, 09 Jul 2025
 07:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250709005952.17776-1-bijan311@gmail.com> <20250709110648.52688-1-sj@kernel.org>
In-Reply-To: <20250709110648.52688-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Wed, 9 Jul 2025 09:07:14 -0500
X-Gm-Features: Ac12FXyKir0QkPAHnX3REi635GLE0DBv9wAGdZTw6dhXQX_ellDr1zjsx8QPpQI
Message-ID: <CAMvvPS7avR+xEk7e+n5X-rwDFnFCf3e7ubJPHAQfRQVmyZJMjg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] mm/damon/vaddr: Allow interleaving in
 migrate_{hot,cold} actions
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com, 
	vtavarespetr@micron.com, ajayjoshi@micron.com, 
	bijan <bijan@node0.bijan-262664.superpages-pg0.wisc.cloudlab.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:06=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> On Tue,  8 Jul 2025 19:59:30 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: bijan <bijan@node0.bijan-262664.superpages-pg0.wisc.cloudlab.us>
>
> Maybe this is not an intended part but something from misconfiguration?  =
I show
> Andrew merged this series into mm-new after removing this, but headsup fo=
r a
> case that we might do rebase.

Sorry about that. I had to switch the machine I was generating patches
on and forgot to setup the git config. I'll make sure it doesn't
happen if I need to resend.

[...]
> > Revision History
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Changes from v3 [10]:
> > - Fix bug where huge pages would be split
>
> Maybe "walk->action =3D ACTION_CONTINUE;" of ninth patch?  Nice finding!

Yes, that was the change.

> Nontheless, since this was found by you and didn't discussed in public be=
fore,
> it would be nice to add a short additional clarifications like above, if =
we
> (unlikely) do rebase.

I will do this if a rebase if necessary.

[...]
>
> For the entire series,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ

Thank you for all of your feedback and time spent on reviews!

Bijan
