Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198937;
	b=euzDjNB+uRIOe6LObrP3A71LdDNlv71bF/+FNbrfCtTPfa+2L5lN/3K9xa+COGXsyGZH
	 MSZGsKTU1E+EgLuQGZfw1x8F3BjCoRaje7CPzAI8Os0ZuSb34NDUNSro9uq8thhEGEfG/
	 qMG82jFxNDpVM1oA3JnrU12USTvUVy7uI0P3BszHckXqKExwXjeXGe06eS6n45FGaDCJW
	 FfQoduB0RZFP38EunyWkDcFe79rf02pfuxQSOj172FOoMD+RQCeJbTCrdp+C+S223fqXW
	 r8n7eb14U4iySieai6EeNUUMkaSwgpyu21XaY4xCVurtIhgvfIGzrKdLI7qdvrgLwug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198937;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Id7gQwjqaNnSQF/sAzYU9HkwqDon3ENeXE4+42htTA=;
	b=k7fzCD8e3o6v4Fau8KKgC9hfUMx8nN1UMN5jalq35aKTYiKpuCriVR3Bx+2tK7UGr/N1
	 +Q6wDDG4z8FzsxsuIMdlulDUC36AQTr6/Nqun8tQFJabq5Z4oPwCxENZgHEYYvzeZaWWM
	 WNvXZACdW59bkCLKtEvazibIiXL3gmif+NnAuDLO8IbGorP1POztmyGcdB4qi/Y8oJdwm
	 PgtJCghtFnPbIxpMbSaS+S8e0ZzpyRYYXmxCn0E9KmbUkXIhyLIXoJT7xSuxvCoN3eRK9
	 Ul2wwy5I+r3DVjxLOCQADog0ZIS48JIR6/XXthRnOQsfAXEGSmd6SzKjSwgVVnTbuug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iacauZo8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C76606A897
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iacauZo8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2331F000C4;
	Fri, 20 Nov 2026 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198936;
	bh=8Id7gQwjqaNnSQF/sAzYU9HkwqDon3ENeXE4+42htTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iacauZo8HZZkDYjN6hpWj6UPN2AihGd0NTfskiUVVoH2FNpd80FTNXMcouyUQ6dSM
	 DUBcZxeGxycCL7+fzeZyunlleZ3K8T08hEEbKHaoE06VzPzsahN4we2VRcSB/gDtLf
	 uQ5/cpq9SWgUWL9LCw33cvW3GbsPiFuwtDPngUoDPrL1CaB3DNqpfJc05YfBvgeNkH
	 2wXyIaGLnNnqtmQ9qEA4/x/smyb5eR4etDDI58gnFglk0tcOW/iiHfjsJzJSsnO2e6
	 mRWmErx8KSWjw5HBvRMworDPUcekjAU3vOM+XIdydl7g5A3FvuSO7yly43ozEIHvLM
	 xM2Su7L2j1x6Q==
Message-ID: <sashiko-outbox-225814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/60] mm: introduce the common-memory node state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-3-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-3-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:22:15 +0000
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
> N_MEMORY is overloaded with two meanings:
>   1) a node has memory.
>   2) a node's memory is reachable via ordinary allocation or
>      an arbitrary MM service may use that memory.
>=20
> Allow N_MEMORY to mean #1, and introduce N_MEMORY_COMMON to mean #2.
>=20
> N_MEMORY_COMMON nodes contain "common memory" capable of being managed
> arbitrarily by the kernel MM based solely on zone membership. Following
> commits convert relevant N_MEMORY users to N_MEMORY_COMMON.
>=20
> Expose the state via `has_common_memory` so userspace can identify
> the memory available to ordinary allocations and common MM services.
>=20
> Add has_memory to the docs while we're here.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D3

