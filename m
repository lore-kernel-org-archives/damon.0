Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66133BB48;
	Tue,  7 Jul 2026 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383239; cv=none; b=cPfZq0VMtfgcSFiLMz6A3X6bHxg5DHA98i1ijCEuBckbRceQq7PPcKq9i97V9o7DIklbLsBji211742gaFbGJCUO1YnU44cExDEAdPjJmat3H3ftatVlsJQ2Q5jaVaza4pU12bzQoeTwXK1PDhUpVaFyLbs1fVZeuq9U3BH4E3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383239; c=relaxed/simple;
	bh=/0NVCbWgX65HWRuxfBgpZC6MLIvjEpKKOc5Y9vHiX7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyAUW0sUeGX6tQ7T1pSmYb1KhTDvttXw2t1voPHjwd0e0KjqSpH38zgbBcIPa8MJ5g/+pN0/WzAXf03xxJBU9OLHkIEhhxM6F/szAjLkRN3s9siTuIrp6ebosDQBkCy1jkGR39RQQo/7g6pnUzWKPc+Czdvu4hTrF4vJ2yIlras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfisRpmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfisRpmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4061F000E9;
	Tue,  7 Jul 2026 00:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383238;
	bh=eB1zO+hEcVPqicULA2t7Fk+v6ErU6JNrcgHBtzJJkzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QfisRpmL2Q7w5vhJODKT4L8MN52r2hKZK1CUd5JBD+iHnkyyQ5OhUgtVxtUeEg9lB
	 eNxlm7zM36O9+peBNmx2jkzYsEVdlBRHCfLrIgKRpICoHXwykEeEh8hOEm9BrRBFYV
	 o2OUt+qNG7f6ak+9jD8DgsavWkBS3gZs9X+WBIk3e5iQ53XnmJd7+ENMUET9bp69qs
	 cyjgB1Rt5a/0BQfxxMrKkWX+XW/D2oQjJXAnR75wh3q8zqOeFqiHRtcAZlYytGCg/o
	 sjMu98VOEpUkOyXfnviw9v4NUmS3Ic2lpdJ0rsLD0Bfoned6QsYjD1y4JHy9C5VsDc
	 7MpJqJeD2tHrw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1.1 00/16] mm/damon: introduce data attributes only monitoring
Date: Mon,  6 Jul 2026 17:13:51 -0700
Message-ID: <20260707001353.98054-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  6 Jul 2026 07:18:54 -0700 SJ Park <sj@kernel.org> wrote:

> TL;DR: Introduce a way to get DAMON's best effort accuracy monitoring of
> user-demanding non-access data attributes.

Sashiko is continuously finding a few things including integer overflows from
wrong or weird user setups.  Those are minor issues in my opinion.  But because
the core layer parameters validation patch series is merged into mm-new, fixing
thosse should be straightforward.

I will fix simple ones in the way, as a part of the next series or as a
separate series.


Thanks,
SJ

[...]
