Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012746;
	b=4T/T35cam+I02bS1RJ3lF5a15cOCRmkEjCSFGUO7wh/x81jMZvoUbO4gAXEoX1VTs21v
	 YgH7W2dZG7uD6FYKdSEyAE5AvrG1kI/oFRVzYA11pHeSlClGugj98JXobbEKpeFpn6fn7
	 reDMZjSRAET3Ub167NJh8z0EzxtCyh2ZIP7xaqS//3IfyAre5h2ESKtreDhT9WiigO8Cr
	 w5081Eb1vE5rSR14kc4kcYqmxsRgC3fq0QvG/m7cbDBeEEARNzfAvQszIlEzsylcViQQe
	 o6U6IwXtiMDyrbuJnbbfXEWmevUSROIaAonTVrB/21gFLhU96ERd2ig/QOPWtyCtekg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rjd1gO2DkC/w8IWUFk8m3+lsSMXbDWVmqHDE2Dov96g=;
	b=Myd+E17eN9PaMR8RIjqBGT9lwGa9dDR8KnWmd3ARJMjmZU+avwvcAT4sZLJRIJ2RfqGY
	 3Vqk963SrpxlaEiXvii6Itg+KBaJA8QHysHqBqHN7ZqOrIKL0DXwRgAc+pe9ki2lEBdwB
	 +8Rpg04f/i4GhYFhdoVGZFl6Y1xSX9zs1xzgiOa6ppXd0n4DOA1+xJdUIp4nrO64QPbY7
	 Dd0nyhiGtyef6JxqzGc7VUtNF+gVL9ASF58x785qg8OvM7BvKP0RiunbTRcCNCrcafYZy
	 hSZPoKLHl3F0WnlguBXAV8KiE+94mw6RIsB4h6UN10d7jSc0shEBlRmk1+aUqWF8glA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gX89l2c7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026C606A31E
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gX89l2c7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D81F031E3;
	Mon, 26 Oct 2026 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012745;
	bh=rjd1gO2DkC/w8IWUFk8m3+lsSMXbDWVmqHDE2Dov96g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gX89l2c72JB8ThURzY5KKzuX4baulYE47nv7a9hCd7QHjt9dbidxdOd0wQJKliOXb
	 nEcOOvkM1jVJsaJ4gLgqC9bjlkYi14wpIqOL/FJvUQ1pHLLvRquL8aGBoCMOqdem/P
	 0P8qiqWi2Lo0C7CBx0B4dbQijA5T6ueYQQZ0vu4trqkZ418FjEEv7f+++9+HI0R6dU
	 V6z6JvJUm94X3HBh7YhgeXc4FE0ynXEXS1CKPqftYVrxLASF20vL2I6AVtPACbBJAS
	 iIOM55PSttyHgzmvHwtq1ny/65Kq1Cq8eWTRxaZy2nsaLMGf85jHWJYYnlMlxaBFQ4
	 TO8scRZeT7AvQ==
Message-ID: <sashiko-outbox-185052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] mm/zsmalloc: remove unused zpdesc_lock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026-unused-sym-v1-7-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
 <20261026-unused-sym-v1-7-82ca2dceabe1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:05:44 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> It was added in commit c1b3bb73d55e ("mm/zsmalloc: use zpdesc in
> trylock_zspage()/lock_zspage()") but has never had a caller.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-unused-sym=
-v1-0-82ca2dceabe1@amd.com?part=3D7

