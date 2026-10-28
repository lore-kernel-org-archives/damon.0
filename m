Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162101;
	b=twIcVy2wI6CS/4hjJxXdLnUeFeMY4tSguzNg7HSEVImYQ4+nPQn5mr51r//kmgB8K2or
	 XlKvEyqTxnTTer0mhYB5TTCl1szbpdsJs7kWsr3MM0JQ82hvbJIQ4Vfh6Z3X87tL/eEZ2
	 pXvkdlLahh8YVloClapYD+/pw3KQYXW4tVKMhEmJlmh5uqyq0hrEBSb6S8YTL3FKPR9dV
	 YI+0x7KMmoHJu3ExqTq2qNaXMCjSWzfhz10OH4K1TEvqDDb89EMDrWzbXv8jkQVwRDmW5
	 mREWcb7u9zsbX/liIRrQBLfX/l1XmbWkJ09AG6jNeGg3rC2mCEpilEqaM+NvPcF+VSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162101;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=quvVJUU03iVWecNiyjr0G3ZcdtCD1MoA8WAqOuNtqa8=;
	b=hpnmtHMZevghF/g71lolzCZMhCL5G7SDCd2ty7vIKqxR08BhlEAOVn8icztJ1I2TmNcm
	 elHUSVvOgGI8vJ6vfGz9VV7NOreDQh3RBffYoJF6UbD3wtJLJGdZgQcwBiyiqQ6B38qZX
	 /XQqKc5NxKTsiDvM8vVBsH5oZzFix7a3ES5bYFSsLD4LTGYZPXEfUoscinL7Q9CAUcYjh
	 j6QnVMlsx/MnIQ/84d+wp1XZ+5+TxrzR/cSR+Zv3HRahB6RzR9iv5sNteACJkdSO9JD8U
	 pr/Up9eoYxsTNOy+4aBPQqLaSJFEoabUrDdB+XR8yS4WwbpBt/fJyT5DvgvaZ88mV2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQjYyVyV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68454606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQjYyVyV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEA41F01825;
	Wed, 28 Oct 2026 04:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793162100;
	bh=quvVJUU03iVWecNiyjr0G3ZcdtCD1MoA8WAqOuNtqa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQjYyVyVwpAqkjYmn8Tic22neMv335B85I77XN/rHuqKCY05MJNNpMawYq3ZdEHnV
	 fVEZa7GwpBM1J0IO6ifGkajXghzYr5FTAChETq5tyQ+RB6Y0gf3bYC8caGlmhx+xLY
	 EKXxXNH0UcXv0lZIx5Zeu0fOHdodyrMztW7t8gCHTRenL4EM/V76im5J/bKxP9QIcR
	 4sJ274weMLN5j86l5IWpPmhFXuURvdey0zvCuHzK8V9gSwUkVUVaGwbGB90wJh4oP0
	 9bPC3tEUuW1KUdDd/wLPDF/zR7+XlLfTIzij95q+FCK3rVD4wjSRZ0Mrz7bXgVaj9t
	 f8LWTyL/B8iIQ==
Message-ID: <sashiko-outbox-187490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y 1/2] mm/damon/sysfs: put target pids for
 damon_start() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028042617.165657-2-sj@kernel.org>
References: <20261028042617.165657-1-sj@kernel.org>
 <20261028042617.165657-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 04:35:00 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_turn_damon_on() allocates and sets up damon_ctx to start.
> If it is for virtual address space monitoring, the setup increases the
> reference counts of the target pids.  After the setup, the function
> invokes damon_start().  If damon_start() fails, it deallocates the
> damon_ctx object without decreasing the reference counts of target pids.
> As a result, pids can be leaked.
>=20
> Fix the leak by putting pids using damon_sysfs_destroy_targets() before
> deallocating the damon_ctx object.
>=20
> Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spac=
es monitoring")
> Cc: <stable@vger.kernel.org> # 5.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028042617.1656=
57-1-sj@kernel.org?part=3D1

