Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9C3B28D;
	Sun,  6 Sep 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721521; cv=none; b=ta2Qiquvo4UnFo4EyBwq1fxAF9EbE9EvS+MQPVgtv0MLa3tVSYCHWol1yoyvdbkTQW6yZi23g0brbPhGz/ZM30mgU3U/GthdlHoJHZARYYsKdw06Mgm9pJ5En8Zwbflubkj6Y/7oCER7XwyuWeN3Fmm5pGyokTzWLu0ZpOz1n+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721521; c=relaxed/simple;
	bh=lETY9aZwq/hOoo0xW/rBFXJkJiGG6zoo/qAU1fjk32o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKy3dw6QES+sIRT/UHswzuDry4gnta1ivMxadGeVj142ez3TCeIPuGwDAbVezBqEe0SStZnZ2+QnUQ5PW3ztvP0Ug5mran9vEljWcUYDgjPJ2K6M1E3soeH5mndTRXSFWdD7tx2jmTlKaMPQAr/OG/Cqa3ls5BSd+qgePeJ8DYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0DSUdFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0DSUdFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF241F00A3A;
	Sun,  6 Sep 2026 19:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788721520;
	bh=dtAM+2bE0Rt5IW1MUTCf8ImDEJDLu+CH2iU80hmdl/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i0DSUdFT3c6tYVS+//GqcD97I/17wah1Ryw8N2s1nkwwrEScYCZKdLGfnZvC/WTpF
	 53Q8JEqP+DoBDKx+ywlx4UIAinCp+Ze68MJkbvkMD5wq6UKf+iNSkvPrtv17YGBv4x
	 wVoqXaJ1SGuXL/znhrd/UgapwfNetF8hSRMEOJjvU+fyljxPYw/JyepxHblzox9Z6K
	 hEXF4WjHCWn+iQRcIKp/sI0IFWMUp+ySZoDSNrrst07GS6pGZNTI/HEyJd8bDOcDmo
	 G5y7wjqgWvuLGQ11XWo4vqq1broom0+UUDt2bUoPl2X5Fz+vQ5D43wFZ+wDDxDIcGW
	 7dr1AoJoszn5Q==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/5] mm/damon/vaddr: support {prep,apply}_probes
Date: Sun,  6 Sep 2026 12:05:12 -0700
Message-ID: <20260906190513.98247-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906184417.96621-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  6 Sep 2026 11:44:10 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON supports data attributes monitoring.  However, only the physical
> address space operation set (paddr) is supporting it.  Add the support
> to the virtual address space operation set (vaddr).

Sashiko found no blocker for this series.  Sashiko send its findings to damon@
mailing list [1], and I reply those if anything needs to be clarified.  Please
refer to those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
