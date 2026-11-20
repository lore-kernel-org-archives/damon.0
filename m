Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198903;
	b=wI8ngYQbTm20DAzzfXc8nR1TpAocH9Dok0KN+6XjLApUeyI/2NFS51j0vj1AA+1VZpwB
	 brF+5MjfrZRKGNUmeJacSWNfBZOcRS7ODaQ2C7By0e6vkpE84oqvMAQYvN+/YgZsmzsHI
	 EhGiVEQWjdF1IB2f5l/X6DV8pLkuxog9h/PVTn5bsnM1sCBGSjKmKA+sI9brP5N7VWRuq
	 738VfNe3j7r3Y3NM4KnxQ3/mBvyOOhoOpZOzPoaMtqwUeUnw/y3O8gweYF271YfzOBou/
	 YqcaH+cJt5gN3xP0SdTDJV66ez4rAbO5HVNmLiP9JO1QvD0UmnAgYQu2z4RTHkkIsPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198903;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0KnMKn28stx4KXvLRf83k//TIO4P14FTZxmMi/Rto4U=;
	b=J0bJtQnPWGUqLZ5J01LZIfh3IJdxceVpaQPCJUjukVMWSMQhQNM2OBWt6OhAKNUtU9Me
	 KQK597QpJf1+CUQMVLYNPy8skAKjDQq7w4frJvtH6J118YJgptm0ppWIxfnJ5VeGu0zQ8
	 tkuY0Dgnk/zcIp4/aN0qsDuSnx1TgWkIcEoAusWEoyOfmXSAUY5s+v0iJ5ArTaYQdihy3
	 BIb795YItWywASlzOkWcT0TwxH5LZfkAoopkSUT0tYAv4/VuPxJoLJ/vcBiDhA6nQZt6C
	 fNANvCcWT6aHl6KvRITiwCXCpIYAdHxbVxgjzRCu3xpyYxhq6DkrsKHS5hdNqeCRaYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRBLM5fc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDD606B447
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRBLM5fc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BF81F000D4;
	Fri, 20 Nov 2026 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198902;
	bh=0KnMKn28stx4KXvLRf83k//TIO4P14FTZxmMi/Rto4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jRBLM5fcSgzvdl9euXTss9ha0Ow9dfKTyHoDmJxSRhJgO4X1exVVRqctDbSBsA47x
	 A3aTbsex8LUv7INzuiDbREajSOiiU/7CDn3LZFoqCcBj3YRBgf7xxr/JBnOrNGi24g
	 8KuYA6dGKuD2Jz2DEjQWE0T+1fO9sT/UI6ilsC9Zmdd5YmxKPwjwzEqM6SRBtHiD6h
	 nJ1r7HSl3o42fYk/6dh5ONuHiX/k5gKvc66qtE5rrhBJu5nPhu7Wl0bxR4vDOyip3r
	 sO+9r10Lg1LJ7Y4d9Wc4hpEesZuz4v0s2tkZ+KXXmiAciS5i7YEsJbmwAwK4T+S+Zk
	 bA6x4L0ogFmPw==
Message-ID: <sashiko-outbox-225811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/60] mm/migrate: leave pages outside common memory in
 move_pages()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-26-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-26-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:21:42 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> move_pages(2) moves the pages a caller names, and reports the node of
> each page in status queries.
>=20
> Leave pages outside common memory where they are: refuse to move them,
> similar to ZONE_DEVICE pages. Status queries move nothing, so they
> still report the node of each page.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D26

