Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774900;
	b=mcP7GWTcNbY6gjQ09bHl1z38kASAyHxFMGzvklk54wNHMsEDVzNEKihT1ZuQfPAsWPgg
	 BZA0AYUam3fBMruG7nE8JMsovYkNpn09ZKoDLCMxLY2nltX4ADHqV6DjpCP9u+YNesIL1
	 LlHIrB5vxh9bagM4jRSOXO6AOmyuCkiMZodRiXJFW6Ul14I+KZ0J8P/9NVKgV/ifVK92y
	 uX301hqYCkp9Xl0cX+K9fSrdy/gVAbMeRb3zDh1/5VRiy/jE/1QXrSJXfjs/8s5rqAP2+
	 F4SOVJHBrvkR1SFbPA/tOrtcB2rGPSB6bob/AbP6eCVTxOkLhqsgjjWCcLVAino6+4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774900;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uNYYaWn4YF72pjUR5TDHAyihlRnuR+8l9LU+n4VEAYE=;
	b=gP9GZlFSZnXeldIXDATGhd0P5q3radRsGkChFUktxNCNWiLn4oCVyqExlWBPbJ4H4klX
	 /G+jifI09WpxUcIcnTf0a9OsHxQhfEK2Y6Yx+YUoGOZ0w2/4HL5eJ67p43PvzIycWq3BI
	 S6ka+03/Em4Jer0nTBYvm1NhPR8bN5oVTeFWAKYopHgb91OY6vPNeRCk8k74l5jP/t7hK
	 YAcbhZAo5lyYrMVxlJboay62D3S5U4VwzTABdtyhgkUWN+Cr4HbMoounSNhn3s0lss19x
	 lLYdH7DxqdHLJH+CG0Pa1eSgwpg8fUY8x035TJx6ETE3PQcxAPFtQCznZhqtt3vVeGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJhLI8M8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA54606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJhLI8M8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FF01F000C4;
	Sun, 15 Nov 2026 20:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774900;
	bh=uNYYaWn4YF72pjUR5TDHAyihlRnuR+8l9LU+n4VEAYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZJhLI8M8DRM/RjZhtJ7KRvhNO4oVXKoDBOMHdEcR5cCLwoTz/CRZ+hD5I8vhptSpA
	 q11QS4wjAiQ5KxxnFJ8uDNlILv4Mkgper6RZtmDWxdpA4K4HAOsVPLxhw8OUxZS6DB
	 fcp7Vkwcpz8pj9WYI6pWIDYKqxqeySY3EE/Vzf5XtWQawe9XA3RUODuiZTK9RkIbcV
	 jKECd+XxSxX5D4DZXD4I/ifcdWZ1TIJ9zPtpuO977LEAAcigSJJwftZ7+qWjHciAfV
	 Sa3lPOlfFUsttRqvioIlGcTHN06ww+lsuo5P1Abpi3e9rn63M51ZydNSpA6Elj/97g
	 wtt95vbuthelA==
Message-ID: <sashiko-outbox-215842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 22/27] mm/damon/sysfs: implement report producer
 addr_{start,end} files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-23-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-23-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:34:59 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement addr_start and addr_end sysfs files under report producer
> directory.  Those set and get the address range of the user_report type
> data attribute reports.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D22

