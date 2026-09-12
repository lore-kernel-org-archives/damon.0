Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5F368D4D
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241018; cv=none; b=HVakWFnb7HEOBsV00Q2niopLIUzga2AIfJ31EV2g6RZQX9lqqXv11C0XSobOOOTH0rJBpDAJ55tSPak+PSxICEk8Y1cyBmg1RIqOTF6g7xzznWz4SUzi19r4jgZIXs2puIunuqr1ONiZHY8BfvooHEL4edB4RIQMvIBQeFDZWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241018; c=relaxed/simple;
	bh=Xz/0P9ahkW5O57hDoxlUYSBmC4bfYmJ2OjX5r1tFXS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tRcG4LwtJozUcaEHYXdc12aV+/GqmzJzy2slLVASdMARosk1iFlO6nohRB0WYB4zXdDLaj2Zuux3FRphZYPIbY/9xmyeo3QmmqIv7y4dY8FjICZdsYESjzNZb+wb9v1f8UdqSz0yv5n0mZibW5qjy+LPYRhMho0P7ESMEn3YHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayH66Kfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayH66Kfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F1F1F000FF;
	Sat, 12 Sep 2026 19:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241017;
	bh=/ECUq3fJLkr89eKvI2wco98bp66D2aAxWHgnyiI+gq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ayH66KfkB3AQoMiLCRKy+u5nOvrd2d7zO2PArLiZsAUmAsu62k/+rhMB25GElLXa/
	 mHjEI5xOgTtPSNddgez9fxN9wRsOxZ6mZThkW+Zx37HhtYyJpIWpAozgyOts2GMZuX
	 NW24JfLaLcqYiO01i/0sDmMmqWU6N9Jq3IGtZUwSdJ4PXG0vpQ4zx8VbAY/gYbDtJB
	 aDWtQgshfaIg66hCXd+n0d4egwdYKD7kVpQZT+/wo92xCzrrSxECvuIgr9Wy9iPdeH
	 zPxHLOCv6f0gZEEFZ/kG6dkjHh1XpCTm1+VV7gOnkS4vwX3meq9VBHce+uwriEs/Xk
	 gAoD6rZQjBBQA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/8] mm/damon/sysfs-schemes: use switch-case in
 add_scheme_filters()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912191807.138502-7-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
 <20260912191807.138502-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:23:36 +0000
Message-Id: <20260912192336.F1F1F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_sysfs_add_scheeme_filters() has long if-else chains for DAMOS
> filter types.  Convert the code to use switch-case, which would be
> cleaner and more efficient.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912191807.1385=
02-1-sj@kernel.org?part=3D6

