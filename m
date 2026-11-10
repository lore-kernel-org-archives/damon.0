Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300916;
	b=xq13UNhDwn9CYmE75U1mgiCJ+IdNHzkQUKuVqHQpDjg+XEfoNvH6DT7BeU70SD+yIsAY
	 GxX20KeM2QTa5i/enQUcrDAZ5WH3cJ8jTKAubMObeXfOekIRotZzKOicZbRL6arq3a+gQ
	 gh59SqJ64M/ylXhjFvv3ioJ2xmoqg9+Ui1E7aGF53DeLR0mfZnLhA+SO6atWsiVH4aI3l
	 J2BURPck1uXoYFes+u8dBLzX1zsNtC6du+W8fDIjYqIXUGX2ULuvv5p2tsELuvuJAZrbY
	 QEegA0E9sH/lqii2whBgjE+VNBW0AwSzmHCz4ixLi+YMAIvDOHmtp1jv/qokiFul5wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VoJmpsIla/y0sHzCmi64L0xEySQhXNAybHsk2OGI1tI=;
	b=fylLQTq0bpI4c7fLO/8Px3F002Pq9wLTWiPcMYjCnYWhAbCQLfzSCiqfyIjQFDdQL4cg
	 Zhdgo0GAKwzj8F0zUbfW9QnYE7HfTOsCfMjhbNNuWki+E8lY0qlC9F5lkWuVa0YKLzOdW
	 JepB/JkT1i2D17MB8zDQ6y91xcnFq83GDem8cADezaLi8oG+xvwmXZg4I8LBRVRbQA+/4
	 S9pfxnOgyg22yrYH9TVN/NEq6KkW7nCSxTajSXcaeeoaHpPxJrXhfc1ldWSDQckAN9JfE
	 vXZ9oPzFU2C/Mjee/5ZNrgEmRo+QxSf0zKKDBsa8hM4Whowbbf2tSdhUnEvAsNeABSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZrmtWIn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9860A2614
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZrmtWIn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385831F008BE;
	Tue, 10 Nov 2026 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300916;
	bh=VoJmpsIla/y0sHzCmi64L0xEySQhXNAybHsk2OGI1tI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZrmtWInISHVU1sU4wf/43giuL9lU5k7VnKKD/0FWc8SyGgqhHZyMQ/xZVgPZZLf3
	 NjAFbpKY+KwiXq6Le6XdgYiNhcPnxRs3Ewe7jTREyjvk4Ip9wzYs6CfQB/2kyu7/Ls
	 tnlx9Q2e65hrn3cBq0mqEyJDR3GCUN6lH5csReZwXkU2DaHiZqC4KA4sLzoZvNlLvq
	 5YraNorsnbYBwzA54eCOGEF1N4PHYLD8bUju8ELmlUm1sJ4OoBJ2PHVltioDAJOeJL
	 PQ0JPB3cdZ9ipGtnBEfZB0XOuxHV3I0ShT1I2gMGDbSMD+UMMOPIQz8Fw8THBHE7HW
	 /5FqyXdS6BA0w==
Message-ID: <sashiko-outbox-206676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] mm/damon/core: simplify minimum watermark wait time
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWRyaWFuIEh1YW5nIChMZW5vdm8p?= <adrianhuang0701@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110085132.1023-1-adrianhuang0701@gmail.com>
References: <20261110085132.1023-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:55:15 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> The minimum watermark wait time calculation uses an additional boolean
> variable, init_wait_time, to determine whether min_wait_time has been
> initialized.
>=20
> Simplify the logic by using list_is_first() to identify the first
> scheme and initialize min_wait_time accordingly. Subsequent schemes
> update min_wait_time only when their waiting intervals are shorter.
>=20
> This removes the unnecessary boolean variable while preserving the
> existing behavior, including the case where no schemes are configured.
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110085132.1023=
-1-adrianhuang0701@gmail.com?part=3D1

