Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810639E177
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890426; cv=none; b=UhhiopqFSsE/xuK47JbT93IgBIusH37Ld9yrllQ43c0XWUwE84ct1fV5ZXm5v5QIalSFlaal9ce+QdNPvUinivqDkqqgihGxllSQfY8hlhlvQdt39MlPKUMYbZS5zruDT7UUfOXh1T+3g3iU9f2AVeqnleasdNaOsC5j555U/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890426; c=relaxed/simple;
	bh=/UeMi+JaZA3u+VpJfUjNutnV4evOAW5IF6lj0AjVMqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPpe9QxLtvUpVJKwxkIvaGTYOeEue0Zxr8qxiWnl6Ut0RWQyHaBZsfEd/dpNCBRGeM++NJJ4Sg6qxLy4jNWGtkbEaFlMCxlN7bsyvER5qjQHJz2X4qj8r3LPwHmAx4VhdFGd2PVbEuuiqw3We2KxvZGIn+A4hpF+rwfT5oH60CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AD5kw1eX; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AD5kw1eX"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=/UeMi+JaZA3u+VpJfUjNutnV4evOAW5IF6lj0AjVMqs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787890422; v=1; x=1788495222;
 b=AD5kw1eXxJl8neo2OF9VN1B7HPwm/QbvdLYuIsNsJdUTXgJ+QrdjYYoijRykkZG/SFyHMl7v
 pzcetuM8TIN2g8YFhL7hh06uSla700DLGK2Fsc6qdEdyKUcCkHFzKcjagEN/4rWOlE2/uS3lE12
 pWphzs3/eOMiaZN3qvCo8Z+M=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 8e322e2d7171c530;
	Fri, 28 Aug 2026 04:13:42 +0000
X-Mizu-Trace-ID: 8e322e2d7171c530
X-Migadu-Flow: FLOW_OUT
Message-ID: <88698ac7-3a60-45b7-908a-7f1521c021aa@linux.dev>
Date: Fri, 28 Aug 2026 12:13:20 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 25/37] Docs/admin-guide/mm/damon/usage: document
 sample filters dir
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251208062943.68824-1-sj@kernel.org>
 <20251208062943.68824-26-sj@kernel.org>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20251208062943.68824-26-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/8/25 2:29 PM, SeongJae Park wrote:
> Update DAMON usage document for the added DAMON sysfs files for
> installing and setting the access sample results filtering.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 25 +++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index 897a89950351..365a4548a5ba 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -66,6 +66,8 @@ comma (",").
>      │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
>      │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
>      │ │ │ │ │ │ sample/primitives/page_table,page_faults
> +    │ │ │ │ │ │ sample/filters/nr_filters
> +    │ │ │ │ │ │ │ 0/type,matching,allow,cpumask
>      │ │ │ │ │ │ nr_regions/min,max
>      │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
>      │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
> @@ -233,7 +235,8 @@ writing to and rading from the files.
>  For more details about the intervals and monitoring regions range, please refer
>  to the Design document (:doc:`/mm/damon/design`).
>  
> -Under ``sample`` directory, a directory, ``primitives`` exists.
> +Under ``sample`` directory, two directories, ``primitives`` and ``filters``
> +exist.
>  
>  contexts/<N>/monitoring_attrs/sample/primitives/
>  ------------------------------------------------
> @@ -245,6 +248,26 @@ to these files, users can select whether to use the :ref:`page table accessed
>  bit <damon_design_pte_accessed_bit_access_check>` and :ref:`page fault events
>  <damon_design_page_fault_access_check>`, respectively.
>  
> +contexts/<N>/monitoring_attrs/sample/filters/
> +---------------------------------------------
> +
> +This directory is for control of the :ref:`access sampling results filters
> +<damon_design_sampling_results_filters>`.  At the beginning, this directory has
> +only one file, ``nr_filters``.  Writing a positive integer ``<n>`` to the file
> +generates directories of the number, named ``0`` to ``<n - 1>``.  The generated
> +directories represent the sampling result filters to install to the DAMON
> +context, in the order of the directory names.  Writing ``0`` to ``nr_filters``
> +removes the directories.
> +
> +Under the individual filter directory, five files, ``type``, ``matching``,

nitpick: "four files" in this patch and "five files" in patch #32.

> +``allow``, and ``cpumask`` exist.  The first three files are same to the
> +properties of the filter specified on the :ref:`design doc
> +<damon_design_sampling_results_filters>`.
> +
> +Users can specify the cpumask of the filter by writing it to ``cpumask``.  The
> +format for ``cpumask`` input is same to that for other cpumask inputs like that
> +for cgroup cpusets.
> +
>  .. _damon_usage_sysfs_monitoring_intervals_goal:
>  
>  contexts/<N>/monitoring_attrs/intervals/intervals_goal/

Thanks,
Zenghui
