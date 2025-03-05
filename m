Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE625A338;
	Wed,  5 Mar 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213438; cv=none; b=FvWHJSASLgjL5Zm5liQnqaZfekptfKep5vx0blq5c9DOWPkxMnZ7tZ3MxuBvSiEASwexYeUZGbbVLNqjJu4FVxmHNWGKB6FRBOkPSv1sOHWmfpX5eW2aRHngJav2/soeIUCNi720aWkIFT37ytOly9tGn9ZEM8vaee3ZLxR03yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213438; c=relaxed/simple;
	bh=UyiIL9B4tM3RCfI9R/ZLxpaa11lZTPqHt5IKJfAcnXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0+N4+Qve/L/ALJaDokjHJD/fdUWygLH0mZAvyFIvijbRrL/QyBrBdxm8svy120d/bI4eEl4dDv/x04UAUC9uAxIOD0joxUZ+PGblZQE0l0UMq1F03ZbmF+Ya0N88dD9EK8Y9PF6zj2TOAZhCKoiUsVPCRDGSAm3M+7o5RZRFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Los+nP0g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Los+nP0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBF8C4CED1;
	Wed,  5 Mar 2025 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213437;
	bh=UyiIL9B4tM3RCfI9R/ZLxpaa11lZTPqHt5IKJfAcnXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Los+nP0gHv7/zH3wkmrw+GpZkCNU6zP8J6NmxNXnvuOE0pAwhohGptRCCuEaVDQ5j
	 nxqHJBiId46iCdONHGq+zSuZd/Ri6Vxylefs6Hid2PXCmdc3opNJvvOEdlZ2E7sxrM
	 oUVgyb4YJKsWN1vfl0HpBXMUVIuqqq3zUyHVDlGKDYQUaHH4hR+w1FVw4IqCfYEKPq
	 0xkqatStDbiGjEe4H8ygtDEWqePGjFjYhMLux7vAW9yud2tL/mmOJi3J7hg46kZIAT
	 iElPAvxafzIuKayfz/qNA6jKA2tbwBzx5T1gJx5rqtRd63rcAJOlrHGp2XIdWTI2mx
	 QsO+wLkRzA2ow==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 8/8] Docs/admin-guide/mm/damon/usage: update for {core,ops}_filters directories
Date: Wed,  5 Mar 2025 14:23:55 -0800
Message-Id: <20250305222355.58522-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-9-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 11:46:46 -0800 SeongJae Park <sj@kernel.org> wrote:

> Document {core,ops}_filters directories on usage document.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 31 ++++++++++++++------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index dc37bba96273..4b25c25d4f4f 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -82,7 +82,7 @@ comma (",").
>      │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
>      │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
>      │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
> -    │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
> +    │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
>      │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
>      │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
>      │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
> @@ -282,9 +282,10 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
>  schemes/<N>/
>  ------------
>  
> -In each scheme directory, five directories (``access_pattern``, ``quotas``,
> -``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and three files
> -(``action``, ``target_nid`` and ``apply_interval``) exist.
> +In each scheme directory, seven directories (``access_pattern``, ``quotas``,
> +``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``stats``, and
> +``tried_regions``) and three files (``action``, ``target_nid`` and
> +``apply_interval``) exist.
>  
>  The ``action`` file is for setting and getting the scheme's :ref:`action
>  <damon_design_damos_action>`.  The keywords that can be written to and read
> @@ -395,13 +396,24 @@ The ``interval`` should written in microseconds unit.
>  
>  .. _sysfs_filters:
>  
> -schemes/<N>/filters/
> ---------------------
> +schemes/<N>/{core_,ops_,}filters/
> +-------------------------------

Just found this causes below document build warning and error during 'make
htmldocs':

    Documentation/admin-guide/mm/damon/usage.rst:425: WARNING: Title underline too short.
    Documentation/admin-guide/mm/damon/usage.rst:425: ERROR: Unknown target name: "core".

I will fix this in the next spin as below.

    -schemes/<N>/{core_,ops_,}filters/
    --------------------------------
    +schemes/<N>/{core\_,ops\_,}filters/
    +-----------------------------------


Thanks,
SJ

[...]
