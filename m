Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421B3AE1A6;
	Mon, 23 Mar 2026 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274793; cv=none; b=R8fvbKvWDnpiv+47UWClWxi7u7SCIUvXRCFEr6Q7xrQfYzuaKrtCd6hX5fBoJD6X5ayD2ipmtnowSU919z7BC/so3JKWx7ftdt3DguI7QRnn1VfqCHGtHzsx/njNUBPmL89to5tofmJL58ODEbEz7ksJ+y4k/uRKyh849/doyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274793; c=relaxed/simple;
	bh=kWkRZysw2zl4SGpODfVg1gRksORKKSk2p5v/lAci/gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktONT/DyJy0UMlhF/vcp8Ky6Gw3yBYOXPCfIBJefIU45j+fPpYD5QbV8eSadiZbZjofxmrS9/odVNchgCIr7Pkgk60CwwrDwIFDA/7+7sx8AdkxjQR5EMYj7sae9HI8TPGdEDFl64m9Z28rvyZq9rrxldAozrK2rhUZdil09SR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXhhZoDh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXhhZoDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B53DC4CEF7;
	Mon, 23 Mar 2026 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274793;
	bh=kWkRZysw2zl4SGpODfVg1gRksORKKSk2p5v/lAci/gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXhhZoDh1xlzRdtNioCo5fcVnBOKPPHc+KSgUrYbO3t0sBRMiC4MB2a8Ri3/h4IPJ
	 ke6jfsPtz+uLa0gJqTpRFHXy7aij0dZlbfeRf/fYknU30A919f385bz9Y+ZPVX162z
	 AQXFlIK7lpJb8BVAthQN7HKrA00jK3/wvGLps3dboqg1v/BiVVrE0wCqYjVXlIXc9J
	 GctHQ8JQu9LqET0oUeFuLFwjlVz7eKQz3DnecDARvsFU6XmQi2LYq9ZYVSR4EWmnIW
	 6qhOkLDpoqE7Nyzfh2qeUcO+exHZdP24vNi2CGFUCRpS33eXU/s/FEzyov5wHwrFQ3
	 ch3zAp7q5MrLw==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] mm/damon/core: Performance optimizations for the kdamond hot path
Date: Mon, 23 Mar 2026 07:06:24 -0700
Message-ID: <20260323140625.79976-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322214325.260007-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 21:43:23 +0000 Josh Law <objecting@objecting.org> wrote:

> Hello,
> 
> This patch series provides two performance optimizations for the DAMON
> core, specifically targeting the hot paths in kdamond.
> 
> The first patch optimizes kdamond_apply_schemes() by inverting the loop
> order. By iterating over schemes first and regions second, we can
> evaluate scheme-level invariants (like activation status and quotas)
> once per scheme rather than for every single region. This significantly
> reduces CPU overhead when multiple schemes are present or when quotas
> are reached.
> 
> The second patch eliminates a hardware integer division in
> damon_max_nr_accesses() by using the pre-cached aggr_samples value.
> Since this function is called once per region per sampling interval,
> removing the division provides a measurable reduction in CPU cycles
> spent in the access rate update path.
> 
> Changes from v2:
> - Fix multi-line if statement alignment in the first patch to satisfy
>   checkpatch --strict.
> 
> Changes from v1:
> - Use min_t(unsigned long, ...) in damon_max_nr_accesses() to satisfy
>   checkpatch warnings and improve readability.

Thank you for adding the change log.  Please also consider adding links [1] to
previous versions.

Also, please consider giving at least about one day before sending new revision
of a series, so that people can get a chance to review.  If you find something
that you need to change on new version, you can comment first about your
planned change, and wait for others' comments.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
