Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE530F526;
	Wed, 14 Oct 2026 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791937989; cv=none; b=K4hr55Gku3O8L8h8WoCOyrd/doUJf+0pZQfFjKi8TXJ4g3n4jNOt6rK4tasa8S8+FJX1E1KJS5BdBVW6SwukwYySZoRihCV81EsUIuuR6qBZU1aj4pBuld1b8JntaFtMcDADrdvy6o0jmba63WGSgzyTXW7tYsOg7aerbaJTYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791937989; c=relaxed/simple;
	bh=XoeuaYCroNGCUaVY2XELJFZgOyuVqlfBsQDBlYVIens=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8KFg6gGhZEDUnaJ+tuyMZqgXs6a4eIaaWFrzsuvZsSFNeskH7aY89Pk/KQlTVJJ6fG79SteJNDd/74xA4f4XRX8nKoTuJtyFlZjBots+zEBrCq4rZPYUsrKHAetB4YJ64uR7KYDW0p4NVuZFl1uI7W1MVhzUGt7eICAnaWb+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcNyXWkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcNyXWkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2593A1F000FF;
	Wed, 14 Oct 2026 00:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791937986;
	bh=hXI2gIMzgROodmXxlY8UYg7eHDDceK9gOOniFQNAk3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AcNyXWkWUiQ4PmIL1fwRebTfyWsstTYXhBeyKhU+mcHsOK4XKeaqIrJK4CxdXJFXI
	 w6Tqmdq1ksw8EOrmZiMcxp1EwzRBEbCd8GXxwM08ZEjNIn+OlhPm1iaoLipPpgNVGF
	 c5Xb9ZAygZOUILD1+FzcuMStKk6WtkwiyzxA6NgtsD7A26OWQGCj7pgQU4a2tJ6RIg
	 cdMHCIp1RwDdfR4LXV1D4rCUkwtuXB89+JkVNKnIpdzI8hiGktU30WZYJPB57OJ5Ns
	 euMCZeC8vAfpJiT0sIKEW7Gub3rFwRyyWRKU6VkMf9WS0jQDF3DsoEWLWF2r7Q6wyf
	 PFHC3VJAJirHQ==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye
Date: Tue, 13 Oct 2026 17:32:58 -0700
Message-ID: <20261014003258.142926-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013191327.663331-2-manuelebnerli@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Manuel,

On Tue, 13 Oct 2026 21:13:27 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> mention 'least-recently-used' AKA lru at the beginning

I think the readers would know what LRU means, and therefore
'least-recently-used' is not needed.

> set as -> set to

This commit message is using incomplete sentences and describing only a few of
changes.  Please make it to use complete sentences and cover all changes.

> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  .../admin-guide/mm/damon/lru_sort.rst         | 51 ++++++++++---------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
> index 0c04d238ed..3b6d122887 100644
> --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> @@ -4,8 +4,9 @@
>  DAMON-based LRU-lists Sorting
>  =============================
>  
> -DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel module that
> -aimed to be used for proactive and lightweight data access pattern based
> +DAMON-based least-recently-used-lists (short LRU-lists) Sorting
> +(DAMON_LRU_SORT) is a static kernel module that aims to be used
> +for proactive and lightweight data access pattern based

As I mentioned above, I don't think the above change is needed.

>  (de)prioritization of pages on their LRU-lists for making LRU-lists a more
>  trustworthy data access pattern source.
>  
> @@ -17,7 +18,7 @@ systems, LRU lists are normally not proactively sorted but partially and
>  reactively sorted for special events including specific user requests, system
>  calls and memory pressure.  As a result, LRU lists are sometimes not so
>  perfectly prepared to be used as a trustworthy access pattern source for some
> -situations including reclamation target pages selection under sudden memory
> +situations including reclamation of target pages selection under sudden memory
>  pressure.

I cannot find what's wrong with the original sentence.  Could you expalin?
Also, I think the updated sentence is rather easier to misread.

>  
>  Because DAMON can identify access patterns of best-effort accuracy while
> @@ -28,9 +29,9 @@ pattern source with low and controlled overhead.
>  How It Works?
>  =============
>  
> -DAMON_LRU_SORT finds hot pages (pages of memory regions that showing access
> +DAMON_LRU_SORT finds hot pages (pages of memory regions that show access
>  rates that higher than a user-specified threshold) and cold pages (pages of

rates that "are" higher?

> -memory regions that showing no access for a time that longer than a
> +memory regions that show no access for a time that longer than a
>  user-specified threshold) using DAMON, and prioritizes hot pages while
>  deprioritizing cold pages on their LRU-lists.  To avoid it consuming too much
>  CPU for the prioritizations, a CPU time usage limit can be configured.  Under
> @@ -63,10 +64,10 @@ enabled
>  
>  Enable or disable DAMON_LRU_SORT.
>  
> -You can enable DAMON_LRU_SORT by setting the value of this parameter as ``Y``.
> -Setting it as ``N`` disables DAMON_LRU_SORT.  Note that DAMON_LRU_SORT could do
> +You can enable DAMON_LRU_SORT by setting the value of this parameter to ``Y``.
> +Setting it to ``N`` disables DAMON_LRU_SORT.  Note that DAMON_LRU_SORT could do
>  no real monitoring and LRU-lists sorting due to the watermarks-based activation
> -condition.  Refer to below descriptions for the watermarks parameter for this.
> +condition.  Refer to below descriptions of the watermarks parameter for this.
>  
>  commit_inputs
>  -------------
> @@ -74,9 +75,9 @@ commit_inputs
>  Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
>  
>  Input parameters that updated while DAMON_LRU_SORT is running are not applied
> -by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT reads values
> +by default.  Once this parameter is set to ``Y``, DAMON_LRU_SORT reads values
>  of parameters except ``enabled`` again.  Once the re-reading is done, this
> -parameter is set as ``N``.  If invalid parameters are found while the
> +parameter is set to ``N``.  If invalid parameters are found while the
>  re-reading, DAMON_LRU_SORT will be disabled.
>  
>  Once ``Y`` is written to this parameter, the user must not write to any
> @@ -86,37 +87,37 @@ violate this rule, the kernel may exhibit undefined behavior.
>  active_mem_bp
>  -------------
>  
> -Desired active to [in]active memory ratio in bp (1/10,000).
> +Desired active to (in)active memory ratio in bp (1/10,000).

I think use of brackets is also fine.  Let me know if I'm missing something.

>  
>  While keeping the caps that set by other quotas, DAMON_LRU_SORT automatically
>  increases and decreases the effective level of the quota aiming the LRU
> -[de]prioritizations of the hot and cold memory resulting in this active to
> -[in]active memory ratio.  Value zero means disabling this auto-tuning feature.
> +(de)prioritizations of the hot and cold memory resulting in this active to
> +(in)active memory ratio.  Value zero means disabling this auto-tuning feature.

Ditto.

>  
>  Disabled by default.
>  
>  autotune_monitoring_intervals
>  -----------------------------
>  
> -If this parameter is set as ``Y``, DAMON_LRU_SORT automatically tunes DAMON's
> +If this parameter is set to ``Y``, DAMON_LRU_SORT automatically tunes DAMON's
>  sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
>  amount of access events in each DAMON-snapshot, while keeping the sampling
> -interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as
> -``N`` disables the auto-tuning.
> +interval to 5 milliseconds in minimum, and to 10 seconds in maximum.  Setting this
> +to ``N`` disables the auto-tuning.
>  
>  Disabled by default.
>  
>  filter_young_pages
>  ------------------
>  
> -Filter [non-]young pages accordingly for LRU [de]prioritizations.
> +Filter (non-)young pages accordingly for LRU (de)prioritizations.

Ditto.

>  
>  If this is set, check page level access (youngness) once again before each
> -LRU [de]prioritization operation.  LRU prioritization operation is skipped
> +LRU (de)prioritization operation.  LRU prioritization operation is skipped

Ditto.

>  if the page has not accessed since the last check (not young).  LRU
>  deprioritization operation is skipped if the page has accessed since the
>  last check (young).  The feature is enabled or disabled if this parameter is
> -set as ``Y`` or ``N``, respectively.
> +set to ``Y`` or ``N``, respectively.
>  
>  Disabled by default.
>  
> @@ -235,7 +236,7 @@ max_nr_regions
>  Maximum number of monitoring regions.
>  
>  The maximum number of monitoring regions of DAMON for the cold memory
> -monitoring.  This can be used to set upper-bound of the monitoring overhead.
> +monitoring.  This can be used to set the upper-bound of the monitoring overhead.
>  However, setting this too low could result in bad monitoring quality.  Please
>  refer to the DAMON documentation (:doc:`usage`) for more detail.  1000 by
>  defaults.
> @@ -268,7 +269,7 @@ This parameter is for setting and getting the :ref:`address unit
>  
>  ``monitor_region_start`` and ``monitor_region_end`` should be provided in this
>  unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
> -``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respectively.
> +``monitor_region_end`` are set to ``1024``, ``0`` and ``10``, respectively.
>  Then DAMON_LRU_SORT will work for 10 KiB length of physical address range that
>  starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
>  
> @@ -291,22 +292,22 @@ If DAMON_LRU_SORT is enabled, this becomes the PID of the worker thread.  Else,
>  nr_lru_sort_tried_hot_regions
>  -----------------------------
>  
> -Number of hot memory regions that tried to be LRU-sorted.
> +Number of hot memory regions that try to be LRU-sorted.

that were tried to be ?

>  
>  bytes_lru_sort_tried_hot_regions
>  --------------------------------
>  
> -Total bytes of hot memory regions that tried to be LRU-sorted.
> +Total bytes of hot memory regions that try to be LRU-sorted.

that were tried to be ?

>  
>  nr_lru_sorted_hot_regions
>  -------------------------
>  
> -Number of hot memory regions that successfully be LRU-sorted.
> +Number of hot memory regions that are successfully LRU-sorted.

that were ?

>  
>  bytes_lru_sorted_hot_regions
>  ----------------------------
>  
> -Total bytes of hot memory regions that successfully be LRU-sorted.
> +Total bytes of hot memory regions that are successfully LRU-sorted.

that were ?

>  
>  nr_hot_quota_exceeds
>  --------------------
> -- 
> 2.55.0


Thanks,
SJ
