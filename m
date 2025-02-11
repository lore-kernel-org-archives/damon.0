Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE01E282D
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296754; cv=none; b=nHn6FyZzbjYVUlYtKZDH8831o8MdTEwzb5Khe/79L8/mxTM6OTNkT/QYNxPpW21KMsreyVLykqClfFd7Xpd17iKzNWri6+wLPAS/aAB9vGDk8gJPhNAU6FMRCBDPuOg1qtt8Y2pdTRB2kz9kkWbDPtb1Gq7RlvWTzAsZ3vSz06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296754; c=relaxed/simple;
	bh=2ywx7ufl9LpPgUs0eT2/5wFd+RbwbviYKOZZzJdxMs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHGd+NVG8/Dk9M4DBroup2TJnleDWQ72W9lD7CXQI9xRglpebp+F/WfU3jfQaWnKDhbtXTX9ctAZKEDAlA8SBP3DjvnqBl4nxOb5doeX/g/hObk/8R27q83GV9tIEhJfL+w2mqX/CroLEu0XbdnUSYGOPS1GKKxrIAba7kEZG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQMd5kSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQMd5kSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1057C4CEDD;
	Tue, 11 Feb 2025 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739296753;
	bh=2ywx7ufl9LpPgUs0eT2/5wFd+RbwbviYKOZZzJdxMs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQMd5kSzNqjfN4bMd94cgh2gcEekIZXeBg6CH50B4lQtLSV44iSG8Mx8QbqMFh/t5
	 SeitMi2y1uYQbGXyBZ6o2JgctWKQhBKfwlrJ+j/PR3t+8NYBX1N5AUE2Uu6czfXK4s
	 CZ7gPxq0KinTOUoaHe/uxhuZLHDUmB4ON+dROhSP7if0lOPRH7CM6gl302xHoarZ+z
	 0TRQqx6G9gLIqOr9lWhC/KpFsY3YZ6CoAKmHfcdXzLrkpwIF7kt68MMsxF1xnyPykM
	 eDUlVGB8H3RiD2eK2nZL8rTp78njCIH2lIF07JYI0J0br05VPpctdk15kzyjEzfHKA
	 zaQ+qWHttmdTA==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v5 2/4] mm/damon/sysfs-schemes: add files for setting damos_filter->sz_range
Date: Tue, 11 Feb 2025 09:59:11 -0800
Message-Id: <20250211175911.10813-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211124437.278873-3-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Feb 2025 12:43:41 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> Add min and max files for damon filters to let the userspace decide
> the min/max folio size to operate on. This will be needed to decide
> what folio sizes to give pa_stat for.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
