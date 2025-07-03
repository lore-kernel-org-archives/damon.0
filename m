Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DC288D2;
	Thu,  3 Jul 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751502858; cv=none; b=jGTb89F5ngXox5Go0kpZ//Moor8LJODG4Trbp/m1qJRI+bYCCyimqUPkxauXWDtQtUVw88FVy7/G320c2A9IHq8dYyLRWrAJboRL6BDJiivWx4DtiSlYjrRgSyfMqCqwwV2o6NoSRiFwQLYhBVAKoijA/AIf08ZgaUsWKFZOQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751502858; c=relaxed/simple;
	bh=81IE73b32dsNwRovjYtkePZZ8bsWrkodhkQ624T0Dv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zy7bUB6MQ1iu5Nohc77SHhF6bXDRQw3R0HcfulxRW1x93vnafOIPhp1lZZ/8JjfRUaqiVx+wiwi9fFYLuC/+XRHcH4s3r6bBfXCcxS8n+ptnxOET4LDQ9NdVxySPwUtGmm7taaMJreGdPnUD+VC46F2QOYEW+lqP6J5ntMBXT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNBj1As/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNBj1As/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DBEC4CEED;
	Thu,  3 Jul 2025 00:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751502855;
	bh=81IE73b32dsNwRovjYtkePZZ8bsWrkodhkQ624T0Dv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNBj1As/cWNyk0G0AG2YqlDoUJ35xURyWZGzhOUemgYJvSnGaYRNxdzW76FDMS+lI
	 BtgFaJcXmek98zhRv8+JT2Dhtj4QlIVOlqHvks2jtXsxItonTbKpq9kD3zzUW+1DXa
	 Pg6FgHK32qxOAOiv9j818Q5r9SZQkjb9oUpOySF/RCpFy6h7tk85opElhe999rs0OD
	 o0vZUB75ooPBOXeQ/k8SOeK0hjXqQawiVbINSWFG3akqgE2RAu9dPDvKC8l+Xxy/dR
	 kcD9nRZ8jhzfUYNa9PFofgznBzTsGwTpv00oodUZY8XsXwuloQJG+jD6DlDDfRjiVh
	 43qcQXHDnJBYw==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: Re: [RFC PATCH v3 12/13] mm/damon: Move folio filtering from paddr to ops-common
Date: Wed,  2 Jul 2025 17:34:13 -0700
Message-Id: <20250703003413.57520-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702201337.5780-13-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Jul 2025 15:13:35 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> This patch moves damos_pa_filter_match and the functions it calls to
> ops-common, renaming it to damos_folio_filter_match. Doing so allows us
> to share the filtering logic for the vaddr version of the
> migrate_{hot,cold} schemes.

Nice catch!

> 
> Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
