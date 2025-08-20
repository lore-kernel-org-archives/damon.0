Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D613314A5;
	Wed, 20 Aug 2025 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725828; cv=none; b=bUzOITCw6iW9cMRZg7EwV49teyjKbtm2OUe2eqaV/Z03TWIr/LshLWHd8W6oBLyXCmWTu8Fykp/2RAC4ABRcKkq3pKE12jHYpIkEeCuF4mndM6xT6w0rXR4q0sCPAz84iosOIUMWi+CsNLE2nn+QYaoKRnhgllzoh7seplcPshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725828; c=relaxed/simple;
	bh=G1jauyIK0PJiSZSgp++rufvWeHOToe2iJQ3gQ4t5BWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUvJ/O0DCnBdyUBZnTJ07XWl/45d2PBmj2esG1upNhV7qvHozF9+pqT4wUaN136OGTjLcnv9dcq+UAzoePkleEjr3tjLSCOXlYg4g3qAcwEGgI2zsqVWEh70k81hPTv7UYgB5S5YwI4v3bSLIV2FyRmM9vglUQNNFOcM9W3l29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHWF/04D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHWF/04D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E5AC4CEE7;
	Wed, 20 Aug 2025 21:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755725827;
	bh=G1jauyIK0PJiSZSgp++rufvWeHOToe2iJQ3gQ4t5BWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHWF/04DWRL3ZlfG0omdacyWLaFYIBj1NcBtMWJhQ05HqjA24Lka6fwTsJiSgH1PY
	 GSt/JEYHuJ1BhubzteAHYbc+M58e2Tiy2YaraFzznRLsTi0Um38NZcjjrE6yrFMCI5
	 QyO9EJbptaImVQKe1CJuhlDNhkYDldwJj7aQh1kI6fpQe81rF8r4inuoZ6bUVRKWG8
	 vp/VYBfgGwVqs66hrsKenAGZ3nsMJwDant45O9PkntvTrwPGRxkMms7dIkgqBcGQYd
	 V8q12GK431i2YLIjEvHC4Sdbh5B+8pSBgYTVyXF1rYtJsBkJqfWaG6mD3c6Sq/YPPw
	 0JsvzThfE+mYA==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH mm-next v2 10/12] Docs/ABI/damon: document addr_unit file
Date: Wed, 20 Aug 2025 14:37:04 -0700
Message-Id: <20250820213704.86407-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250820080623.3799131-11-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 16:06:20 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Document addr_unit DAMON sysfs file on DAMON ABI document.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> index 6791d879759e..cf4d66bd119d 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> @@ -77,6 +77,13 @@ Description:	Writing a keyword for a monitoring operations set ('vaddr' for
>  		Note that only the operations sets that listed in
>  		'avail_operations' file are valid inputs.
>  
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/addr_unit
> +Date:		Apr 2025

Please update above date.

> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	Writing an integer to this file sets the 'address unit'
> +		parameter of the given operations set of the context.  Reading
> +		the file returns the last-written 'address unit' value.
> +
>  What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
>  Date:		Mar 2022
>  Contact:	SeongJae Park <sj@kernel.org>
> -- 
> 2.43.0


Thanks,
SJ
