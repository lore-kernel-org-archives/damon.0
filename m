Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0124677B;
	Fri, 10 Jul 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693542; cv=none; b=CXd8BkKCRsPFxpACOa5pqvb+iXvovlsHQCxm+NYaEXjxbj4onMtvJGNl1WRLj+s5D3yexMAg0mRnW2XkaGOhP25b1Q/TA5Ni8zFQSw8R6wLwALfD2fzgZULsoaQ6eYKy0KQ4KVmtphnQthwMJU9r+pwNn5LtUTZEh3fw+zj2HbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693542; c=relaxed/simple;
	bh=t7poKbo0WL+sqaWRvXiD34fs/FyH6RahUpxjKAuxYqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqHCaZEIg3i2/pL1C68tdct+K3foGTH+iug0Zp/SBc7EBBrf/XaTAS2UQzKrMDK7h4gLUuuMEsu6MDeeEjuFW5BKPyKSukNQsJmPWkdDgnTHgxiep8jcw2zq8sA/4kxmexmMxpOJBVNIun50Kcz6dS528pkfSHO+bE22a8A3zBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2BO+ksY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2BO+ksY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B7F1F000E9;
	Fri, 10 Jul 2026 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693541;
	bh=djPcu0FaAOL3FlpJ1AH3s2+hbsgy3DtsP6zvFCsTW9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2BO+ksYpiBx37gKYrYNHUh2HlF78n89BGtyuZ73Ta2ah83pclTFsjnnd18tnUgE1
	 CfEg4zYqwCprIe85aRi75RuWGOvj4pWOHdp4RVPGBwdDGxiayiV3pi5kVpJ7bRozsQ
	 K7XPmGZO89OOJJ4cQxovFRQO5tAHtIRKljH5UaLtuwzn/fhxO91L5Nn0ssxuAQKD13
	 e+Pm/jk5CkFoxg3iHZOlLDMawkW/D6pO/Kf1TPI6CqHtVK+SOo0KPQfcNcPbiAitDM
	 /1qVc+q69HTej/99qnjeouENAUVr0gXDpXYyP4mv7zXt9Y7dlDIRcyNs5Q4Yz3JGPa
	 s3pubU758lSYQ==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/4] Docs/ABI/damon: document tried_regions probe hits
Date: Fri, 10 Jul 2026 07:25:31 -0700
Message-ID: <20260710142532.25200-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710044737.561102-5-husong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 12:47:37 +0800 Song Hu <husong@kylinos.cn> wrote:

> The 'tried_regions/<R>/probes/<P>/hits' file, added in commit
> 5b0de1bc3325 ("mm/damon/sysfs-schemes: implement probe/hits file"),
> is described in usage.rst but missing from the canonical ABI document.
> 
> Document the 'probes/' directory and the 'probes/<P>/hits' file.

Thank you for catching and fixing this!

> 
> Signed-off-by: Song Hu <husong@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
