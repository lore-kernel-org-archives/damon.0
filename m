Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4E30AAD8
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328495; cv=none; b=YuJj7ykVoYgCicZjGE7+mxKz+z5xlsbSQ6Z3tIgsp231dtqnJdE/dpsfvPTuf4lpiEO7BHax66Nlt7WYFfhTzwpmwvD90Se08NTDBZ7dUGIns6Q398DT5eMlZmPHd/NyD9rG7UatHot+Jrr4NzUDRBDIugpF24e9j8whRQJkO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328495; c=relaxed/simple;
	bh=/rJ/pr5cixRA5p+SFgj7rVCqTmiryY87PdzM07Wi7QY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kyJssUpm7BgNRiqDerEfYvIhVQGphNmQW0znl9E6etsdt6dYBtrWF1j6hRI5AYTOv+G+LKzhQz7CfoPlTFiIQxUjNzwEgo0evWzzaJYGPbL8v7FKahmuBR2Vgxj+cih3BsECSINjBgPPPmgErhVMH9alaOQ5RdKvE9WyHekvHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbjPq0nB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbjPq0nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040161F000E9;
	Wed,  2 Sep 2026 05:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328494;
	bh=UV8cY3HrP3fQpd0gbfHDuL+chgkmeEW0yQ6tdT9mnXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SbjPq0nBn9IYYcJ2dB2A5u1+Hb32IhAGUSIfFM4lFTTO/HjR6ympVXry7HlgLhceE
	 XctMUZbZKcZMG+l3EhDAPd7CUV6jNdf2JB1unpgJdMym0CBqQHGBhGJpN14Fkq6Dwt
	 byAhA7UP2o8zhbUcDzz7Mu1ncHz2I2tDbJH6IgYWeHhf0YQaPHqsq5BmJlxtl3h8Uv
	 RcsR/JcMqiH1olqw/qeULfFXnvZhtm13k267tt9E6fZGgKD3reCLNe9WYNp6QSk3N0
	 Wnv1QWg4e40YBlYhCVScChQ6nq3U3T0ms4qwcNo/qN5jWgMJfSqaVpuBavk5On5/ft
	 frQe3B3IWbCgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] selftests/damon/sysfs.sh: test hugepage_mem_bp
 quota goal
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-11-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:54:53 +0000
Message-Id: <20260902055454.040161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs quota goal target_metric file now accepts 'hugepage_mem_bp'
> input.  Test it is accepted in fundamental DAMON sysfs file operation
> selftest.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D10

