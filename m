Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE4160783;
	Thu, 26 Dec 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735252067; cv=none; b=lVJkS852C5QC5AWpytiKxkyR2eLPGi8gd9WKuIYJuDliAcnlpQ9nCBW6yczTcaxB2vusz+olgjnGVIijwqTw1S5CJYhf0ROJEW0jxD4Gok9NWGn0ESE5RaqgkesLco4xhYiz9SKdmod3+prelD0j8l3WGeSox+FfURDPb2Fq0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735252067; c=relaxed/simple;
	bh=69r0tPasPKa511yR14Pdy2wkmefE1ecTKdPrHQqw2o4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9xeYfpbgJ3aP+j6QPdaHRzDn48N9aOIzVN9O2KLI1yFVYmwoIWsFYqo1t3ze/oFL1PmSiYSIMRXJVgfpQfXAoPIcyZpJ3x2QEyN3WOgPcSZWiDjqSPFxbfTYhSNYQ/TSsUsdKUVTfc4yIAHxoBNYNSuLWMRkX3xw3KnWELFBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyZyYWLz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyZyYWLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A04BC4CED1;
	Thu, 26 Dec 2024 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735252066;
	bh=69r0tPasPKa511yR14Pdy2wkmefE1ecTKdPrHQqw2o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyZyYWLzstlrzay10t9oDCVOU8VtMyvItDUt5EfWW9lvAxSG+Rkeqt0GvatjEToMP
	 R2WEf8m4z/MU8ujY9TBFX0cG4XTxaBT0S/t69MV4cio6L2nTHPYTsLC0WFfAn75EfX
	 6FgVjtfWmTWPCP427a1dmHfUppJ/YVyqHj32wAsAMpYWaCCZoXAK2ByJftPueTD8ik
	 uYw2/pNPKxXFIwYSCpUMHQ0un5Phg7BwHhjDW31cqCJT8hcwMHIER1+lvSEwj80HXS
	 zSR9cRYjjhYd6cEVsqzd0odGE5zQbvY8pbcfu3CgOFJ3hIUWoo/XVJ0h1vY5WfLL+0
	 9RtY/TDZCYw5A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 10/10] Docs/admin-guide/mm/damon/usage: document DAMOS filter 'pass' sysfs file
Date: Thu, 26 Dec 2024 14:27:43 -0800
Message-Id: <20241226222743.79661-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-11-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Dec 2024 14:14:45 -0800 SeongJae Park <sj@kernel.org> wrote:

> Update DAMON usage document for the newly added 'pass' sysfs file for
> DAMOS filters.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 34 ++++++++++++--------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index fa8a5e4199b1..ab343d6ac771 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -89,7 +89,7 @@ comma (",").
>      \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd 0/target_metric,target_value,current_value
>      \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
>      \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd :ref:`filters <sysfs_filters>`/nr_filters
> -    \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd 0/type,matching,memcg_id
> +    \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd 0/type,matching,memcg_id,pass
>      \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
>      \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
>      \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd 0/start,end,nr_accesses,age,sz_filter_passed

Oops, seems my new patch format script has an encoding handling bug.  I will
fix this on next spin...


Thanks,
SJ

[...]
