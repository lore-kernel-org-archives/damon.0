Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AC212D83
	for <damon@lists.linux.dev>; Mon,  4 Aug 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311625; cv=none; b=m2viS8noLMQ9j2NTWkThvUgYT2LvMq47Z99KB8pVoEg6XcUISbT+0xIuxwv6UV7mbrUMgFA4/VYdTcQGI7eWSmsDd5C6N4OPCHJ9OwGJiWCiDFbGt3aLtnVdf9ufGw8HcgLa0mpFC2+tkrpxl3BkD77q7unLiEXjXRObzVWYq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311625; c=relaxed/simple;
	bh=JD87oyjo0h9OEP75Kif8HVmTzy+bczvFotPrw03deKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuZjbFZczvUnMHhalyxaYIZWL0fjf8gPi7i4SL/Aps8hLxtPuJKsmESWuusho2uiBkjq5S6tDhglQAH8jqVdL/hvV4m5FPUz0Mdeh7cQFyA1Qsiw/tNHW3U+kwN/nfjTXUNLSYg8DSFoqrcuOX7KSLJfy29CGmiv86koOhxT7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN2Eoixp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN2Eoixp"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55b88369530so5377158e87.0
        for <damon@lists.linux.dev>; Mon, 04 Aug 2025 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754311622; x=1754916422; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBHH8t8thnrmI4gj22w0yD0jtRxAsL5QsLKAdRhyfsM=;
        b=gN2EoixpSDUp4VvejdsrXJ5cqnNRI9kXGM5KsSw0O9+VrqtjjBI5t4UbYpFzKDI8fq
         J41rurn1F15igNqlTECuJHvwFb5IaB7g2RLFMht8AAEHO+DD4XQFBjakO1XIkEN0/WHg
         DArLKmH18KQqwIA7aGyS8omkYrgH8rhSJ5b1fs3gZLTW92Z2Ml8XC0VEVwJJBTuAmAl9
         QkUs92JwmEOObGmFkcnZtpYUk15Tbp9rabKjWWmDmFKDvrILZ6KIuPn16uw7AtYxhPQm
         qsJWKoW6d0cjketQsUm5s38XBe3un9ktmLBeGP6CvlHwHoAcuYB7/IFgtVc4fXlFd0Tk
         6IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311622; x=1754916422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBHH8t8thnrmI4gj22w0yD0jtRxAsL5QsLKAdRhyfsM=;
        b=vrKoQOvRmWjRgrqFzqiwXcRb+7qo25gQ9hUoYGt4l9I2r4vIRmtjmV4wQjHstXdX5A
         UU4MfvescWlLVFzpKnTymGHKssr8VTZnbO3tCAMRIqQPa4mRczgcj8aVtCMZ7TY27eHM
         IlQBKa5Xiv9XzeCT4S6yMe9dIxqZyWVsbn55Mdmws5Z6t7t/ItlA24PVhIriLsCPdLa+
         RRY1qfVe+nbzQDEnxhoaZn3oujLcNXg5SMG429HRYtSXv8BX7Se7aIxDW8pvgAWLL1or
         rwe9Qbr4jphP01MDF7kUSFjGZzwz4mXU2DTSYd6XoRxTZxL1CSfWgWDJL1aI7ywFuxLd
         u9Rw==
X-Gm-Message-State: AOJu0YwkQ3py2Hef2n9oLtxTm9KZU6s9deYAdjwHrs7Wqmrol5Alhqsu
	tszf81QcIlj5cRNDckF8qm8xgZ9mqAqpevB7WV1VcH9/Glq2AOYCStE4hUkXx+l3bVLrS4AWPgr
	xLY0GNeQx1thL0wTcvDnBz9EXqBXWcHk=
X-Gm-Gg: ASbGncvcifMmeUTRew0MzS01/H9GU4YXcccYFyxjd3gCDyZ/QREXcrCVuuXvSqAf9VQ
	vBZ535Qx6luO16e2knJlIpAK0Y0UiZMtGJFwafeqmuCkL54nFiOw9jnOBRfWhXur+9zfb02a+Jo
	m9/stxT1lslie9HSUy73G9Ko+BBvuasxBJI8u2GBxGvAZJlZS5TlDOsuxK3t/PXv+cBW3qsaECx
	QU/Leg2YmCWdYTbvt/omxkhja7D627I
X-Google-Smtp-Source: AGHT+IEdQ4ILkNf8bWSOywDCzmijyh4yM/0Sc2W8YW4EjdDN9uVworl/jpwKX3OinGTkO9CnIwZdvTw+X4Gws+ZaJ88=
X-Received: by 2002:a05:6512:31c8:b0:55b:81c4:5f22 with SMTP id
 2adb3069b0e04-55b97b7b1ffmr2527830e87.47.1754311621678; Mon, 04 Aug 2025
 05:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250803130028.162537-1-akinobu.mita@gmail.com> <20250803180107.56197-1-sj@kernel.org>
In-Reply-To: <20250803180107.56197-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 4 Aug 2025 21:46:49 +0900
X-Gm-Features: Ac12FXy5C2UUWCHsLDgzD_EXYZcQj8IE3shGFNyhJM8POFKwKnIgvbJ4sf5LZKA
Message-ID: <CAC5umyg8eje0C8i6KTQPUXgi8O8S3p1TsGe6-1VKr3vRJ=Ao7g@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: avoid unnecessary migration between
 target nodes
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Bijan Tabatabai <bijantabatab@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

2025=E5=B9=B48=E6=9C=884=E6=97=A5(=E6=9C=88) 3:01 SeongJae Park <sj@kernel.=
org>:
>
> Hello Akinobu,
>
> On Sun,  3 Aug 2025 22:00:28 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > This change avoids unnecessary migration by checking if the folio to wh=
ich
> > the migration is applied is already located in one of the target nodes.
>
> Each folio will get a single target node among the target nodes, based on=
 the
> weights of targets and the virtual address of the folio.  So skipping the
> migration because the folio is on one of target nodes can result in wrong
> behavior (not doing required migrations)?
>
> Also, a similar purpose optimization was already made by Bijan.  I guess =
you
> aware of that and therefore Cc-ed Bijan.  Could you further share differe=
nces
> between this and Bijan's one, and measured additional performance gain fr=
om
> this patch, if you have?
>
> [1] https://lkml.kernel.org/r/20250725163300.4602-1-bijan311@gmail.com

In my current DAMON setup, the target nodes for migrate_hot action
are 0-3, and for migrate_cold action, they are 4 and 5.

I'm looking for a way to prevent unnecessary movement between target
nodes for each action, making interleaving an optional choice. For
instance, I'd like to avoid migrations from node 4 to node 5 during a
migrate_cold action.

I've observed a difference in behavior compared to Bijan's patch, and
it seems there's a need for both approaches. Would it be possible to
introduce a new option that allows us to specify whether interleaving
is forced or optional, and then adjust the behavior based on that
setting?
