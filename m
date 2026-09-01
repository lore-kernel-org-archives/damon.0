Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F82F3C18
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269795; cv=none; b=j+5APO0gnJ43CPHOYp/ctMWXRjNiyPWmgeRHW3d6tvHLgzJv2UMte5IUCXzCNNlVrdBXk+gub4aGbE8Aew5eaQQ3fWbTs8s+DnfH736Cv9O+lyigHNaNHVVlkNERa1kQgmZvHax7IETzkiDUf2o81SjK4J0fhD7tKojZ6ix92PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269795; c=relaxed/simple;
	bh=Kh51WXU128dyu3P5s2Qn3xZq/YgUGgMKbEBooUOSkyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A9XLuHmKsxiR3pQ1+OTgrIE7j+DgXd/fSJDRJ1VCs7Jedq7N1ISVatf207bk5ax+TCsJe0cT1q/jLf4MHw2QYS5gb1n9IzN3dElc95Oj4uh4wP1j+2v44tTx+rfoCzujMketQfX1Yvcymz5236LKT/nvfEzf0sxr1MC0rNSwBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAv90xem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAv90xem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4421A1F000E9;
	Tue,  1 Sep 2026 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269794;
	bh=SC/MGZN8jfqfQtbvD4joInrBtf6UBzNNJHaN3mj0+w4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAv90xemdR1tgxpXFsH3z9yJUUuaW6WEoA7RLNguOO214YZ12pfK4+/xXY0oJw4bO
	 enFoBzKL8BymvvIyriVKxt0gaO48/XEWNWQsyZLV6G1L5jIi9j3Jnv2BgOhuX9d2dy
	 PEHas6plAkRimnVOS6m+3s7KYabJNzGjdgZk6iUvSSOn88gL2/od2yDb7yH4ZPb+7n
	 qXj7LxOcMxBVSlEYgJJDMZtAeNjZdIKbWHLKx94ERZMZGCmeS/hFNj2L0kjbxtwXyV
	 oXA01uYp/josdZ+Es9Sne4q2REo4cP9Q+0WRxt5wuf9UecZAntjWlRrnEMsGqSJRFw
	 8vTlNe0RWVJDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 05/17] mm/damon/core: introduce damon_prep struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-6-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:36:33 +0000
Message-Id: <20260901133634.4421A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Some DAMON probe filter types require preparatory actions.  For example,
> pgilde_unset probe filter can say if the page was accessed but when.  To
> answer the second question, the PG_Idle flag should be set at a specific
> time.  It can make life much easier if DAMON can do such preparatory
> actions.  Introduce a new data type called damon_prep.  It specifies
> each of the preparation actions for each probe.  DAMON will execute the
> action for each region per sampling interval, like it clears page table
> accessed bits and unsets PG_Idle flag for access monitoring.
>=20
> Also introduce DAMON_PREP_SET_PGIDLE as the initial prep action.  As the
> name says, it will do exactly what DAMON was doing as the preparation
> action for the access monitoring.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D5

