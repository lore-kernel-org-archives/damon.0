Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275907;
	b=Zmq3mAkaNKAToeCXSKsG/SZpaoKw13IFEgVUgzRToUK+IPe6E6Oy/eNX+K9y0HzbkGSL
	 58n6KYs7++JeCO4C0EQObbN6sUOniVHk7JcLiUI8QT/zpmINYq4+IzF9pA88npah9WFNF
	 CYGSPvBNv3994AHTdkjhghsZuxiriPVqD1q+e2WyMUXfeuEJzB4hRyu/ZdScCWKUUUTe6
	 xH8GY46wKZ1mA1QQ+AJU0/IruKXL/sLkcfxS1ykudiLGAwHm9OtCZ4S9US+Ag+8fvuk3E
	 f9MGHq+GJ07tOIzWuxcdPLZfBhBZevpOwV4LNBK5XaL3JUIRdebJA5q7Z/e2nizQcTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=roZz7LmVSoD3aScuGxWLYxZXdjDN/xDFcIukvWWOs9Y=;
	b=Or0PCJeeJBfFbe2rH+ghzA7bEBvM6AY7g39qp9c6EsqHxp+43gr4guwXkvqK+GEtDCKk
	 Gpld2/N7iqdYRjtwk+YEc6TsgdO3AWf264a3Zb6LIjYNHMVj3twKHjfBf6Zv/ArdHPlJE
	 75O0RK8Pa/P2dh+fTErjgXvsj2vqOGbxUS8Uu0pwpdoEATSyZq3brpuqwfVJmv0NwOACb
	 vt0cG67StgB48FknV09o+WNCKYW2obe+Mq+Vn0lrk6u5OzwdEZV6SRuqCKqdGTsJO19/O
	 G6ewUolSmq+nfU1U3XEIGoPN7cDp6vy+AnxRtT+iWEh/o/HMcLGk6pRazS5/+KgMedA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXLLE3zo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AFA606A321
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXLLE3zo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABDB1F0089F;
	Tue, 10 Nov 2026 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275906;
	bh=roZz7LmVSoD3aScuGxWLYxZXdjDN/xDFcIukvWWOs9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXLLE3zokqWfomFwp4RsGQ5HEpn8nW0FEoAA9MyYDORlkfZ/fDEbS9INM/NFkVWIX
	 gX5T2izpStMpDylW8Fcpc+YJLHSBQB3b2KdZKa2evawxY5Ok5lzro6wzEPuzPKT0vF
	 OkV3ApvBeIN7hG/iHqnWoRyS9sA5+jQX0uCOawtH1QwIcRAftC2FZ5QDdAmyY24l4R
	 PkCVcPoeVXMcyMwHTOQf2u4dXQc+R/WVL7+Z5Cq2+1dtSYrb1cqLZ8JSR9NhIT+b0p
	 wJiDxi0XN0whxmODmF6ufvIa61qxIrqBzcDIEWhvGKyFYCPtDqEe9+j7Y0UU30vowC
	 zfOE8lcJTGpmA==
Message-ID: <sashiko-outbox-206008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] mm/damon/core: use node counters instead of
 flushing the root memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110015321.611093-5-joannelkoong@gmail.com>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
 <20261110015321.611093-5-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:58:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_get_node_memcg_used_bp() flushes the memcg stats before reading
> the LRU sizes of the goal's memcg on the goal's node. For the root
> memcg, that flushes every cgroup in the system. The flush is not
> ratelimited, which means it happens every time the goal is evaluated.
>=20
> lruvec_page_state() now reads the LRU sizes of the root memcg from the
> node counters, which are always up to date, so skip the flush for the
> root memcg.
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110015321.6110=
93-1-joannelkoong@gmail.com?part=3D4

