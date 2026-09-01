Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDCA480DCA
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270025; cv=none; b=PnnXBY2Y85lgXkqJ8zeBdGpDeKFSNj9QLi5CKT/LAxpdEBtB3GqW5FB9hOsoz/R0cAv/G8n2F/uq2UNnp5oBRLJ/mWQAfyXxI3NZhMn7hj21vqyyCRjrg1KwPB+oW3qnsrTPzxQR6MCV+sv8DmCi+4R3eILYGUH+0qPQb5mWuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270025; c=relaxed/simple;
	bh=nK0YNLrRGXGuGulef5zSMQ/XGtRJImEG9OrYNN1S3jU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bnkDZQ7P5JmspL644XVJBUFXhFq69z1pWYUE5Clp6WKIbG/82MNlWTb+cLaHx7/S7I6h+qgSogBwiVWXUruzXhJM6bw4H0H9NGf4MuBjDpLF230LdtYZLGMrBNzc0ygfa/MWL0mlcZCj/UtYmaXrHZEetmDvyrFe4ODXYUWY6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmPhcu7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmPhcu7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512461F000E9;
	Tue,  1 Sep 2026 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270022;
	bh=CMiooUPFbc6cZ8mW8K4k1hbkiICGE/Z+YJf7KH6Rsog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmPhcu7IOXJafOTk/JE3gb5IEgEJaSQ/UxFkhSueIJh6tR8PHFyq7cEcafoInY80I
	 W2EApJpc3oxeH1MOQ+0InWIKG28y2WqdnEKuGB1DD/uIuQOQ2Znm4xQT1EBreC/Oa7
	 I3TPj9Ip0U6/S133Ey9qkWdByVQlpPxbS8fLSEspiohOWGDyh/ZCHqr7P9bZsjmQPQ
	 MEqRBtAFL9zeOPO1ccL+HSXlltHf5MxFScvl9WcgD3u4JmZ6fjV8aVBqnL6432ATCs
	 lqeCvFYCb/ldfNAVqDkB31z8Gj7/BZhPd2aoVFtt2GeLL2VldhPlI9QoNWPorMr64J
	 XfyDvCG4Y2YMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 10/17] mm/damon/sysfs: implement preps/nr_preps
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-11-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:40:21 +0000
Message-Id: <20260901134022.512461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement nr_preps file under the preps directory.  It will be evolved
> to be used for generating sub directories that will represent each probe
> preparation action.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D10

