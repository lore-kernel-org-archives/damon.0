Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EF23026B;
	Wed,  2 Jul 2025 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490767; cv=none; b=EVq555MyFSZZqA08tVGWTXm0uK3jpTxtQJ10Z1kdVpEMm6ffpmG3mnEPsLlW5Nmm0zQ2BEOUoPGw8MfVrUrEhnuGuSaJx86hXKMtX9/h3VHETn+/eV55vgaRM7LVFC4RXBGlodo6/LBd46apUrfz3bZbxbmcxLx7/iIyYHdVBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490767; c=relaxed/simple;
	bh=9NKIGUVVUirKI1tb1JfWLkjqKROEx89KEPlFO4hWjZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0gsqVQG9OFW1osfWx8lqV5ZREKez4Pk+xdGPfNljMAy9ZLDUjzi63oxtvxIfYZZUx8eUSIsXs4Vat8aW9B2ZpPSxMmhHS2dAoI/iL0JlKfmmJ813SgTxrxmTRGbUFXqsYNSewDFL6orLrvyQdvkjInTxfLOFozNb73f2lA2McE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ77vzr6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ77vzr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3BBC4CEEE;
	Wed,  2 Jul 2025 21:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751490766;
	bh=9NKIGUVVUirKI1tb1JfWLkjqKROEx89KEPlFO4hWjZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJ77vzr69AvttrhgsTTPlulhgeeeEjgoGi1jQOw6HeDZDE/xe5JRzZvtVmSfKOwQK
	 6dh2D7HW/SVEc3D5v7UNTWEZH2igJhpoxRhVG5V6homSOHHPj/9D82fNrmH6ysfYHu
	 y0h5AZamxF+BfXAgvThXdV4FEzdNI5FiNnLMNk6yH7BZm9h5z8T7b/SKw/AEAISgYO
	 C/KfPOwk66OBlGVfXW1ogoGuedZlGSTZvAdq9CkzaP4sSmO0oHYQOIaNHHyt3xH07k
	 ctFTwAA23NgmzFfmHrnipJJt4Mxs/VHRjAl1NNpFh18t227MsA7+nz3ECaSZ4sT+fO
	 IC2YsU4YpbA0g==
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
Subject: Re: [RFC PATCH v3 08/13] mm/damon: Move migration helpers from paddr to ops-common
Date: Wed,  2 Jul 2025 14:12:44 -0700
Message-Id: <20250702211244.55454-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702201337.5780-9-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Jul 2025 15:13:31 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> This patch moves the damon_pa_migrate_pages function along with its
> corresponding helper functions from paddr to ops-common. The function
> prefix of "damon_pa_" was also changed to just "damon_" accordingly.
> 
> This patch will allow page migration to be available to vaddr schemes as
> well as paddr schemes.

Looks good to me!

> 
> Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
