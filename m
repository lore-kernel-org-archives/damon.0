Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE51480DC8
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396807; cv=none; b=uCiqExKB+HbHN+7WRbpxTiXGRP7GLCr9SdUqem05WVeqAQjrg99dtkGiJ0qjNTuIkEHStjoJsjOUP7Aa9r2v9YUBj+p7q/IkCxu3BV08KFFM8XjNXu5MfL92ALv3eWg/6UmXtXJIDPTHs3FBjwKvX9nX7E8Dlwa+ly8EHYZ54dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396807; c=relaxed/simple;
	bh=An4M/uSwENCzX0zFUVHvdZpAG+Mb3eQxkzUCnKXetCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9SUb/CJibknqQoDvmQyxhjsJdS6sWaKpBBhC60dXilNieTCpJjaIHH4yiHir8df3vJo2pNNYGRIjrcNnLF9+YzfVG2OGQXc+6/w0Ht4quQcfzjwZli7ah5p5dGqxlxH/UNMYhofp3TLVv7iIoRPsFSuWr9bk98Ns8oZDg0217c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeZAGgS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeZAGgS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C491F000FF;
	Mon, 14 Sep 2026 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396805;
	bh=An4M/uSwENCzX0zFUVHvdZpAG+Mb3eQxkzUCnKXetCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KeZAGgS5wrPplUcqo2dwh6rJTYB86N8Zy4YckDTthoIM2nHxP8r61ot609DjHpFTR
	 eF2IYxyEw0X0hZ9zX4uHZuyOsuubZUe+0AkXkTnnY9kLc+ZJyezuGUgKZ0FgZJRd7U
	 1T7nEfuf8aAZLeJb6eUInppOyHBKvRUT5G6FhCgkVhXxHBJrWoitgnuUHGiYQBSRyY
	 gGn+2ue0zg+Bw6JqOvcdZi22TbntXbW3D4qcbUFFeCRTafzLgf1Mnyigb0OoAsDt8q
	 v86XNfiS9ApYNJjp9xUhbbG/+xPS2Ap+ZCRrGPmRDBOc15wU83PGr7VlwxWSL7xJvG
	 suTVvf/Wqnk4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] Docs/mm/damon/design: fix typos in temporal
 auto-tuning algorithm section
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914141952.91465-7-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
 <20260914141952.91465-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:40:04 +0000
Message-Id: <20260914144005.44C491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Liew Rui Yan <aethernet65535@gmail.com>
>=20
> Correct incorrect references of "quota" to "goal" in the temporal
> auto-tuning algorithm description and fix the square bracket formatting.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914141952.9146=
5-1-sj@kernel.org?part=3D6

