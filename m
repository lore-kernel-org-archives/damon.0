Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6E55199E
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655086; cv=none; b=JMhFWbVi4OAT3gqkYkJnHniHywv/ugFDxwOPFpwpy5toi8fJzu8r2uTbh3abz3pR5krnC0srLlP28i8swXDTF6leY8azuS9T6zB1SvCZE/m7eK9JnQ6FtOSQ8cUDI/Qcw+HL3WqsLaeokpOy9eaNtitK2quzBZYmK5T7xI5h5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655086; c=relaxed/simple;
	bh=38CowyNEZL75G6tLB6cCiWNuabvD2shAo7me1lA3sUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G84vuTVAp4+ebwNJs/aaWKOrJ2B8FyBcb3PnVb1/efhecAUkvbw7mf0vGX6u26KHu1Y3LgjEH58HalNx8aWIbGKjIgo7/ZUCgbPlDb/opqAEWGl7x33ieXrem5lIliZZL91HQOE0tyLO9rNcwdtTy8y5zB580tleHgULiV0hwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBucA/bj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBucA/bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6F01F000FF;
	Thu, 17 Sep 2026 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655084;
	bh=38CowyNEZL75G6tLB6cCiWNuabvD2shAo7me1lA3sUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CBucA/bjm/MXesUuH75A4vd4UthwlyfvPIMvLuHF5e3n50SxSt9Qaw8Aw3j1FazcO
	 imtn9BYMw6oujPKt7Ht0TxZ1e2KTfdE+gZuPC258prZAq2yjQKpZ276Sey4DVOJdhb
	 zUi58P1w3OzdqVz3wwGiE4OW346I2OofG6vc0JEuYJ9u7hpT6andDnwjkqP8FszK4P
	 X9BEYbJARrM0Yzy8aaDlBMkDLq9DEcQvUfOx9EEhYCN8nTwnfLb4WMQRJvI8B0IKiE
	 EC6k/eAtGjkUcjRQiuEFCtg+84FTegHUiNXwtqfngRhuW/fbIAKYKHFdCsxg72o6kE
	 vo5KGD17w8Y2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] mm/damon/paddr: remove pa parameter from
 damon_pa_filter_pass()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-7-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:24:43 +0000
Message-Id: <20260917142444.4B6F01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_pa_filter_pass() receives the 'pa' parameter, but doesn't use it.
> Remove the parameter from the function signature.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D6

