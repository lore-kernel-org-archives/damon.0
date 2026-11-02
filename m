Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660056;
	b=a7GhbfFqb7ccrKzYfJPMbSAVOz6moCUZHiYcXz+z4GgNFOc+op87cgrNgInjRzxyYo9B
	 qVNZ14ogtjJJ863ySqPJQ6QRyAtFNt0CDjEpGkB1zLgCmoMzOalknsUe2qYN+jeQPEqrd
	 pVKJRcWBqz2Ntcn2ZJMXJP2Cig1b9URramMPIzvpSOdM4n/JAkYLQIukAyK4rXt3Dw3lN
	 pBin+AVO8PQp9UDbtV4tihYR57y0cfND5WhjuuvhAVPVsyp2H5cyItPmO7YtHAJvN7/xY
	 5P2t0iG/xHR+Pwwwt9lU4cIjBbzpG6CO6EOrUVPTC9wgIAEEh7e75JzEUPXC1ZB9Spw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660056;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F36qo81WgM6aWV+uHU6L49YqlF93BTspT9Y+fxN8u4A=;
	b=B+zEoohrJT3NJ7BRjw+epmQEgopi6y6p9lNHSkn2qosTtt9lQqUT/lvsmPzIePPKLwgX
	 NnC3HEhWggN42XAApkib8VRuw0FkG09E4DLU33WE/jh8cLWiIBE6KJ7G1y9FXJ8DYBRm3
	 GTRmwOkfHLe6beuC4ua2d1DZBZGHH+HTdJf1U6GcI7acwN7hgx3XOLHWhrWFzYuKRSoT8
	 AMBIrP66yOmSW5bfTwnGaVS/CdnMKVf+R8xrYy0zkDcTDjnldB9KwKS/X/Th1dCmZyV6N
	 wKiO4sbDKna32Rbng3yP3iujg9nQ9gR9h/sdCawsNZHWXQHKP9ZDAOnFxqfn2LCZ/Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ES7LNzpR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93742606A324
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ES7LNzpR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9261F00A16;
	Mon,  2 Nov 2026 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660056;
	bh=F36qo81WgM6aWV+uHU6L49YqlF93BTspT9Y+fxN8u4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ES7LNzpRPxM5eLW/dJyGEeeiIVY92LxWvAA7NpZtd1OFzftb9CWwx5QqXKti3dnwt
	 QvSmg2gw/Ju4NUZyuipdMxRrJFwha18tv4+dV2CYYnZlFyUqahnv8HCGf15rBL5soG
	 c3L+NThsmqfsxbHusOVvnam3U8vSL/L+LopZxCxRehuhb9dWzpW5FCq1KapxCvKoCH
	 xytslH1Nnoyoy3oGJM9TyC/9i43+I7GQEJRElfRq2e51sZYjFH63zpgO6khI2Y6Mdi
	 tHxcnHtFfOJgfs+LtG582KkWX4wJTE8Vi+w6joDD1M+FBhx+DcuP8Fomma/KnSIo70
	 EyW/3Lcv30vGQ==
Message-ID: <sashiko-outbox-194305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] mm/damon/core: use node counters instead of
 flushing the root memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102225030.2743129-4-joannelkoong@gmail.com>
References: <20261102225030.2743129-1-joannelkoong@gmail.com>
 <20261102225030.2743129-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:54:15 +0000
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
> For the root memcg, the node counters hold the same LRU sizes as the
> memcg rstat stats, and they are always up to date. Use
> lruvec_lru_page_state(), which reads the node counters for the root
> memcg, and skip the flush for the root memcg.
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102225030.2743=
129-1-joannelkoong@gmail.com?part=3D3

