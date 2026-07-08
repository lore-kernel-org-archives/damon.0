Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F3FBE1;
	Wed,  8 Jul 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477946; cv=none; b=LiRkFe4yXkkanO3v+7w41sggjZxljizylVnJsN1nTMJDAtAfHn0Xug0L10cneljUHKBCDwoKWIUDhXM+rtiOSAuGffDyCviui/dAEJJd6soxwk62gFpCEBmiB+f1o4Ajr/omIP+GBygnMOX6ywuc9sdbwG/R6rdjAib+2OWI8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477946; c=relaxed/simple;
	bh=+Ue/5XBMpXd/0aDqlOuVqtIATI+QDE0Sm65/NRb40Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBrHRuR3Zns16GtZrs+OEVdnIswbl74InQefifyDQkf+qvsA+XaiqFDZwZMiS6OpCuHmP/t01RmklGUDQ62lhunB6xa0IOrZfV0Q7zZN3lYbeXIj9pWXH6bnzN/z4FK1vVIGrfj542UljQRWjNyb5VOtgK6XR8jggsYRd5kMxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLMYqRcf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLMYqRcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147601F000E9;
	Wed,  8 Jul 2026 02:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783477945;
	bh=Obq6dLfAjBdyhlhP1/6V4rwvn+/mhp94v8tQm0g5iGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CLMYqRcfS62VRbTS878OpWNcxvhNMffnof3edE+RAXBjGwiv7/nlAp3YKOc/0HXNX
	 TVcC+p72OZWvbwcVW+kD8laN0bwiAGSRjW/aP0PaWc7s70yo1tMrbKm4jrQz1noC3c
	 fJVSYl/yvJBvFnRriko1gfGrXLv+nh9uq2Q7PtSCLEg9KQwJZ0H2weONjAodd7BCC3
	 HrDc+drAkFBNTw2yRVkYhAp1ZA+qjs5JBT5YTDEwAz+tRpZsnEg9o16uiuno6+Nspb
	 jzDGKFtinJktARi1Uc95hhxmncszECpFcpRxe7vOPDHNk40K3rZdyhvqyzrdbXJ+CI
	 6lbXpH2pgHYmA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1.2 0/7] mm/damon: update probe hits for runtime parameter commits
Date: Tue,  7 Jul 2026 19:32:20 -0700
Message-ID: <20260708023221.96950-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708013252.95888-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  7 Jul 2026 18:32:43 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON users can update DAMON parameters such as sampling and aggregation
> intervals at runtime.  For such changes, monitoring results that depend
> on the intervals should be properly updated for better accuracy.  For
> example, the access frequency counter (nr_accesses) is updated.  The
> data attribute monitoring counter (probe_hits) is not being updated,
> though.  Do the updates for new parameters.

Please ignore this version.  I made silly mistakes while rebasing.  As this
version is not for a review, I will send a correct version very soon.


Thanks,
SJ

[...]
