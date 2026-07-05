Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95A938BF6A;
	Sun,  5 Jul 2026 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278980; cv=none; b=qFSNjClXs3BsquCnkuLzmz6QtYibb/IaBTj75naTX/LpkyqyCjP7s2aNpiIzkbI1/Uv7YP+oGJkXWt5OYagaAH5iyBQvPVOcL6HXH0MjudI99XF1y03rh8Dc4SU3mCrvNVRY+hurRPWSWxJm8Rw2XWDRGmGddp8fZeZ0ooVAC20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278980; c=relaxed/simple;
	bh=qZPWXXaLxCZ1LLbCSbfDtpOfL45gHz9Wdfoa/uYnMig=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gxnBcmaBV5HUg+vNlNMT+wMSlutboy0WRc9mLQAyj/VEMULfjpoaYW77yO9uqceN5ue4xuB07ykV1+xErRbH97ZQjrqucFpq747ePKq8ygGvL424xibQTbB4R+uOY36639ymASiMt15Jzg1EyGmIfKCZZAN1YkayaPoNRo31/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WdMyj3Ei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WdMyj3Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7201F000E9;
	Sun,  5 Jul 2026 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783278979;
	bh=O8V21xSOpKNfbOY/h4eAFkAKGMZa36N1HKOxIElNuMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WdMyj3EinhLL66K8Dk3ayhYYEX6+gLlmTKRbtE7aBxfe1IOeQZYkBj9SCgZIAGzI+
	 rL9Zdh2axQz5YktA26Mm6jYYz6xuwPtJIee4BMDQ3s1FmFAxsokV56kwm4I0D5Ki6b
	 I0w8vJiFyN4t29QAUV5JHz3bLzBLsJ1hjckSahlA=
Date: Sun, 5 Jul 2026 12:16:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: validate all parameters in the core
Message-Id: <20260705121618.48da52edf6747499ba626dc1@linux-foundation.org>
In-Reply-To: <20260705155600.96555-1-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jul 2026 08:55:51 -0700 SJ Park <sj@kernel.org> wrote:

> Note that the patch for providing the validation from
> damon_set_regions() is separately posted as a hotfix [1] but not yet
> picked into mm.git as of this writing.
> 
> [1] https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org

Actually this was included in mm-hotfixes-unstable on July 1(?)
