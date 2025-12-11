Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ABCFC0A;
	Thu, 11 Dec 2025 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765433152; cv=none; b=QZ7dPsYc9yHhaWdP6YNBA04RRSwXJS8xzzn5/fj4lfghKkDlKFQlxmabZ2WXDC/xpNY9B0i05lqZRLluXukGor3E7yvUIGBdBfe3UI/CiAOE6xq7k2vQGFi3jA0dGtPmwgX9/3jqyAVtpBGv5/wFKD9VLg4AoGSqSfuRqYBnTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765433152; c=relaxed/simple;
	bh=7Gc6odwQPHaTgsU2FCJIBG3liP08oRT8KS4tGYydvqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxnifG+Y1v8wDqn6l5e79gD1Htctb9BVb10G2b1Bszl9s00yP0s8QcJb0iJ+yIoTL8nOF7jRImYrJUgihN0dm3Y640GlqCtTQrE9cPv8cUmueKDzdTRaDYM1Omn6L7XgOr0622RVu9uK3GrResycTod+e2HftqXWGAH9LqP0O1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyntbrJj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyntbrJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCD6C4CEFB;
	Thu, 11 Dec 2025 06:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765433152;
	bh=7Gc6odwQPHaTgsU2FCJIBG3liP08oRT8KS4tGYydvqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyntbrJjb8YdKpboqST7GrJnEjz1l0RDixnpjegtQyFrcq1DiBZtxpOYIXOQuo2Km
	 5BUbRC7NlGoGU+C+K28sd+p23yjMOJ5x3ArgNswVR34QQKUpbWPEin+o+0MTkq/xfH
	 JZkoq69/JS9MHSg81kV3j9I0n9qSndQOT/L4rvrnS685MUg0p7rqggt4Q7TSh9/ak6
	 PRjj5DaNHIkGJbesD1Mqcq1+lbCx1ijvyFrR4QjwkkMwqkJDB0l67f8jEdKR2Ql6Gg
	 /hvVCc0vfr6S5OzHtNuK8/n/oGxw9XFWhDPpLbpLs3x7p+evvD/sxJLfy88hrwIzRt
	 SVGpqanE68U3Q==
From: SeongJae Park <sj@kernel.org>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list),
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH v3] mm/damon/sysfs-schemes: Remove outdated TODO in target_nid_store()
Date: Wed, 10 Dec 2025 22:05:48 -0800
Message-ID: <20251211060548.73803-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211032722.4928-2-swarajgaikwad1925@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Dec 2025 03:27:22 +0000 Swaraj Gaikwad <swarajgaikwad1925@gmail.com> wrote:

> The TODO comment in target_nid_store() suggested adding range validation
> for target_nid. As discussed in [1], the current behavior of accepting
> any integer value is intentional. DAMON sysfs aims to remain flexible,
> including supporting users who prepare node IDs before future NUMA hotplug
> events.
> 
> Because this behavior matches the broader design philosophy of the DAMON
> sysfs interface, the TODO comment is now misleading. This patch removes the
> comment without introducing any behavioral change.
> 
> No functional changes.
> 
> [1] https://lore.kernel.org/lkml/20251210150930.57679-1-sj@kernel.org/
> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>

Looks all good, thank you for doing this, Swaraj!


Thanks,
SJ

[...]
