Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199676;
	b=rUMZmVyTOjnAPwdgp4uzwqavnjdIjwbWE2bdiJDUOzX8fy/BTewKHSbQ1V5r44AJszuW
	 qkLh4vO62sPApfdWZ9cFPhwePelTerfJZUI2ShewhzsCp8q1bZv0zlggqDx0jlMZPxsjz
	 BGYPgwRxGYNzwUU0Nok+DgiqUpVcy+5ELnL4a9QKvx2MkwzY/FP0aGbZZlbLDU1ZrXcPw
	 VD/6P3ffFObxggNybcT8rtQNSek7VS8Hp6UQuMkfCAncRo8TyhiU1+viHY+yLuERsNCdX
	 jXDCxKf+KclILcbAbWXm7SsvMFSvbG6mm3eFOEmJh8za1dk2WixsnzPTHBo3Dubh/4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199676;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N72doox323YX9fjsy2aYYC4JoyuD3bXibMAKq0dqhoU=;
	b=P9ay/zMFIFEZl0zRg/23yolfXG/rXnfNRWWcsXivLgN6C8lg8bS/ze3MNJ7Oy/26ZsW/
	 EBWcds4Oqm6pqCi1bQtyw+WysAar6p6pZpKzD6boVfBDUEKV/Z23ov9hB1PyfTMt4XfP7
	 HtuQ62jP8eDt05pbQVi5JCMtW2qxe/mtHg6UjjWniI2dqUieki/rgyJB2pVqDwCmkE4mm
	 Wb0PrSOcgIQG4LV9s0zV6Kai2G8AVBnOY16f92Xi+oRORby8DSE2GqvK+1B2DLuOB8I+h
	 6wjxXJnmSTy34VoIuSC49V5oDVO7Yr6V56YTqeFGVWHXPVKIorw/iXWb+AH/uPA3OLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8sV9tFT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9560A2608
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8sV9tFT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44841F000C6;
	Fri, 20 Nov 2026 18:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199675;
	bh=N72doox323YX9fjsy2aYYC4JoyuD3bXibMAKq0dqhoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8sV9tFTlTV9UkVEa0+4FkPZ9ynbmPzz39JuiqKwp1EqMUbzs1qGLeJQ/CaDV/JmC
	 g/pQgUN2liwEB8b0DkA8bh4Om7ubXa60qOSwNUs2wqxv1JC5LltVLMsWHyCkO44APa
	 NzOr9/UmN5MEV7SOUIjXZ9HxfF57NAficPBs3z4b4nZ+E5/H7FtUdqbCA82K+c+2NQ
	 ghQ44cRih0P0IfLKSlGcXCvRCE88uHZiF2uOZfDaqcgEUPyDYLu8jvomiwdCVMQzku
	 /SLQnBDswJG4ypUe3kdKhocQjeCNC53oNKGP2T95bsksB8M8hWKSj4K8CZeiweIFL0
	 Tt83T1G5VtIgw==
Message-ID: <sashiko-outbox-225845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 43/60] mm/page_alloc: fall back when a bind policy's
 nodes become private
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-43-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-43-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:34:35 +0000
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
> Memory hotplug can make a node private after a bind policy naming it
> was created. A static bind policy, a shared memory policy, or any bind
> policy without cpusets is not rebound when the node's memory is
> removed, so it still names the node when the node returns as private
> memory.
>=20
> The common zonelists hold no private node, so a policy naming only such
> nodes leaves the allocation no zone to use. The nodemask still
> intersects the cpuset, so check_retry_cpuset() keeps it, and a fault
> through the policy is retried forever.
>=20
> Let relax_private_alloc() treat a nodemask that names a private node
> like a private request: once no node in the zonelist is in the nodemask
> and allowed by the cpuset, drop the nodemask and allocate from common
> memory. Only a request on the private zonelist keeps __GFP_THISNODE
> strict.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D43

