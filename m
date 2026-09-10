Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F1D49BD6D;
	Thu, 10 Sep 2026 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051217; cv=none; b=QJVx1jS2hqTYi8yKUtA567R3MasTy5J9tV6/vTz3y0EA+ZFYi//Br0yyUfSTfG/OGKEf41bgt45Fw3iKwFmjXOStPp3O/cjj+WsKAhUfz+YXwIKNsDSsH6GETmpwnn5RcWyuVik4qVrWpz5Wz/0dH41HiVTQSD7p+7VoBTkdWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051217; c=relaxed/simple;
	bh=yfRISRanjw1H3aT/l8T10f0oHjoSPqjx8o6UtE5iThM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7hluam/9gC9xD51o62Tjzv9rcGOOsI+pWWwfVVUnvpBvPI1GxUfGBwrc3n9it34qR+vEPO7yjmpCC723IE51Rzpq/m3resrbnhQLz8A3ausq9GLarWNtXx9Pobu3zHTlzX1L2ujcaeyRKJI7BDGd17bnCNfFER5r2ZkuNr0KUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHeHvxvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHeHvxvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A721F000FF;
	Thu, 10 Sep 2026 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051215;
	bh=ZiIRwFEuHdfHVtyCjAJ5wkFmxjF09C/RketUI/wtcPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHeHvxvptj4gChQtNiKjW0RmyP8s3WN/X4u7TguJSn+uC6oPiO5iLn3mV3KfmUjwA
	 u97EK1rsmi1XOyQtyLiwvn9wi4l9FwDcSwEirpD4+vKLIOvcVnJ2pvmPQRKwfUPJ2v
	 Bj28PoLfuqdse4OEgPvWiifW0DetnkLI7iCiOus5jQSmFo5SoGye1IJAbboNH8h0r8
	 KuJEOnMT04yTd3amLajpElescGmWt8/yEvdnF07vTX3Y3NAKYs/pKDM7kZ1QmOf5UR
	 IwgeobKvlq+7+R95uAbuTL4KM2Krnj/wXDCdfZMVcCYSyVupGPo9QqBwdLxt7AHRY3
	 dU5WNxHG3umPg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] mm/damon: introduce probe_hits_wsum DAMOS core filter
Date: Thu, 10 Sep 2026 07:40:07 -0700
Message-ID: <20260910144007.174043-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910141849.170896-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 07:18:40 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON can do flexible data attributes monitoring.  The classical data
> access monitoring can also be done using the attributes monitoring.  The
> access event is just one of the data attributes that DAMON supports.
> Users do monitoring to make some actions based on it.  DAMOS is a
> feature for automating that.  However, DAMOS cannot utilize the data
> attributes monitoring results.  It is still Data "Access"
> Monitoring-based Operation Schemes.  It requires users to set the target
> "access" pattern.
> 
> DAMOS core filter is effectively the same as the target access pattern.
> It is just a more generalized and flexible way of describing the
> operation action target region.  Introduce a new DAMOS core filter type,
> probe_hits_wsum.  It specifies the filter target based on a range of the
> probe hits weighted sum.  Using this, users can apply DAMOS actions to
> regions of specific data attributes pattern.

Sashiko found a minor issue in patch 5 that is better to be fixed.  I will
send a new version of this series after adding the fix.


Thanks,
SJ

[...]
