Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36723366;
	Wed, 27 Aug 2025 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265894; cv=none; b=qaI+j2qiEvPWGZPpGUKKE+QcUd5OyQP4YOuFmVW9bkKIk0I4OQFmbuWkEOwinf51xyUbmF3zKo0b+zXBBhe8DZNHbXZy69WJndGwPM3/6qabaG1S4u+w7V2FUaXfVe+s7FrX9enH5kSlQVXZJ8DQ++fzYxDk3uedz0qOfme9D5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265894; c=relaxed/simple;
	bh=R04tb9OG4TL09Nj5gld7v76LS6CI1du2iW5ZQJMgkxU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZewpvmxiUUS0Gf1nMN/aeUtcPL7WTQ1dDug4iUv6J93hK0V1Uemofn8hxQOTn2yC29yk8+J7vVrL6d/+tKzdC+x3Wb3tYAwdEmdhI0e6tXyvYU1rVBTZjn5K1U5PaBU+5vPv/CBAyKOazgS4C/HN4Av/qPATHeK7yXcU7dYJbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UfApRqOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UfApRqOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEC6C4CEF4;
	Wed, 27 Aug 2025 03:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756265893;
	bh=R04tb9OG4TL09Nj5gld7v76LS6CI1du2iW5ZQJMgkxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UfApRqOU6xX2QdkOsMfBO9rPsCGbuyQLtHlMhihCKlyI6s9t5YGegVNME/RjUVMo6
	 baxAUQxQk2SGFmlEx66IbT8LdC7uO8oLu2YEaNuLEa6AKNUJtXmk0/eLsozqL4lJE9
	 e2VpIcR/TBt374M59ZOQCkpsPmEA5U3XcPAS/w1g=
Date: Tue, 26 Aug 2025 20:38:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 wangkefeng.wang@huawei.com, zuoze1@huawei.com, kernel-team@meta.com, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for
 DAMOS_PAGEOUT
Message-Id: <20250826203813.437025536948c01b9b307f62@linux-foundation.org>
In-Reply-To: <20250827024244.58979-1-sj@kernel.org>
References: <c8c3d0d5-e9e1-44de-8722-1e7d09786b51@huawei.com>
	<20250827024244.58979-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 19:42:44 -0700 SeongJae Park <sj@kernel.org> wrote:

> Andrew, could you please drop this patch series from mm tree for now? 

Gone.
