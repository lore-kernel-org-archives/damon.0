Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810F3303C8E;
	Wed, 13 Aug 2025 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105947; cv=none; b=hgXG25+tN1VhjZPHh5yCL+0IZKnExcy7bGNfs0XGyDTLhFwmu8/ONnQ1x+3CxD0/11LfvpW6JDJilhBCJv0+mwqYt4Nj02tIAJpIGpCwZbW39zxGaL7VUHhd0CXcKr0+cCp3sJxlSWXgiQ4aJFvSRq56k/vOjcxKadaUhkVZobM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105947; c=relaxed/simple;
	bh=4aNIc6qJ6FVdXPxb4E9sU6AHjxI92V/pZbXVp0oNi9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Th5W0+/bpN7eNoLtXXjp5xcjPt6zn9O9QwqX7Jrkw+F19aT5HUdbyH7M9PfkLQmi0ov1xoECdu+GJ4tSt34Kw4eRAcisrJR68y8WPaGTIu4Gnfsg7W0hdfH9Pe/Z/F5NUag82wN4PIMmJi/yIDBQugRMmoJ8jL4xKRlgPDAWnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBS1uXBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBS1uXBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80EBC4CEEB;
	Wed, 13 Aug 2025 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755105947;
	bh=4aNIc6qJ6FVdXPxb4E9sU6AHjxI92V/pZbXVp0oNi9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBS1uXBUhu/Q49xDBRa0s1zIPcKW6a3bcsI86ceM0ZWhsIeGsFUvw4ghoyLszFEBb
	 vzLqq/qOJ6lo3TZ6XSQb4XpwA3nYunWoa1AJOmTe42c2bGDJQ5cf83uC7zsgXBbR2N
	 vG3xGXKheZhniDaqdBWQW+Cq/3SjiBM3ttF8TsN7NbX4sMLGNlGgvRJz96uKO6BYxO
	 Ojlet5X6j4Bfl8RkhAW/iK0K22nUCpqzD6SGhAja8xBkwdctyyyA8ZR5QTFu0+nUGv
	 ua5/9lFJNPaTJ5e4HK9U0mNoK3pvOG7zzuqxOGixtg431j0SfpvW0EhnfvHckmkwi7
	 HUJUvB7MUmMpw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 00/16] mm/damon: support ARM32 with LPAE
Date: Wed, 13 Aug 2025 10:25:44 -0700
Message-Id: <20250813172545.6637-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Quanmin,

On Wed, 13 Aug 2025 13:06:50 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Previously, DAMON's physical address space monitoring only supported
> memory ranges below 4GB on LPAE-enabled systems. This was due to
> the use of 'unsigned long' in 'struct damon_addr_range', which is
> 32-bit on ARM32 even with LPAE enabled.
> 
> Implements DAMON compatibility for ARM32 with LPAE enabled.

Thank you for working on this, Quanmin!

> 
> Patches 01/16 through 10/16 are from the mailing list[1], add a new core
> layer parameter called 'addr_unit'. Operations set layer can translate a
> core layer address to the real address by multiplying the parameter value
> to the core layer address.
> 
> Patches 11/16 through 14/16 extend and complement patches 01~10, addressing
> various issues introduced by the addr_unit implementation.
> 
> Patches 15/16 and 16/16 complete native DAMON support for 32-bit systems.

Overall, looks good to me.  I have a few change requests including below major
ones, though.

First, let's squash patches for fixing problems made with patches 1-10 into
patches 1-10.  If you don't mind, I will post RFC v2 of those so that you can
pick into your series.

Second, let's keep DAMOS stats in 'unsigned long' type.  This require fixups of
patches 1-10.  If you don't mind, I will also do this in RFC v2 of those.

Please let me know what do you think.

I left a few more comments to patches, let's discuss on the replies.


Thanks,
SJ

[...]
