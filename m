Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E013285061;
	Mon, 23 Mar 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279497; cv=none; b=EOF3cgbmDlV1R4fGcL15NHN3aUWhZ4BXwmA2MDh7m0xEigWPr8BXNJOTn9V4UJ/N+8qkt6uWPHhyjR6rDTMgpj3q3Y3izGAWGiOWJP7dfPc6G2ZFGfs4PmJ8a3zxsBVxvTnmlbRXo6iz67kkGsiYztwUugx98dCJr90Fn6361W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279497; c=relaxed/simple;
	bh=NA2N81AT5PzD0cDhFaHpfI6i7VObtWBhojAn3TCi0S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSJbpNzVXgi73puHjHYWuktIpolB5EF0lr2VPMT8o6Tmh09tDr5bWLmxMstZ3aE6ZgFg6f9ACL6VOo1Oe4+G2m5FMh7fnyLiA4/z+9ja9D3IJnulAP50mPYOJd4UK7yu7xb7lLyzPYuEkW1jblW1SiUdJj6E3oaCIShKw5xy0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYTC+H9h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYTC+H9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0760DC2BC9E;
	Mon, 23 Mar 2026 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774279497;
	bh=NA2N81AT5PzD0cDhFaHpfI6i7VObtWBhojAn3TCi0S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYTC+H9hmRezcuCZ1HcC9go9YWwxE7ee9S/lVdYZvW8px4CyM7Gm/nHDJ45wAO8vm
	 kmYWyCOBhYLomKgevMNM8jcRiULkOlLzykvuLNKG4PYR3YM2nn5ZE9GzQMQe7hm5Si
	 u91OSV68C082COP1aNdEZUmcfVnYzXzQFDwh/qyDFSVDjRnwbsbU8pC2U7MjhTxQ22
	 rqzQsxO2ldnTvi5zMU+L9zTW35RpgSA+qwN5GDmFEkJKD77oMDi9cS5WmNg4NFY10/
	 IBr56DYoIcrBdWvfQAlSjevhmXKMblQPzKJx34gyrHFbmEa1mVRQCEq8QH+rSYLxyc
	 AkfPvE1wctMhg==
From: SeongJae Park <sj@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: SeongJae Park <sj@kernel.org>,
	Josh Law <objecting@objecting.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [v3 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Mon, 23 Mar 2026 08:24:52 -0700
Message-ID: <20260323152453.81603-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0bf54287-b6c1-4359-823c-e47db6f7830b@web.de>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 09:25:52 +0100 Markus Elfring <Markus.Elfring@web.de> wrote:

> > Markus these patches are already merged

It's still in mm-hotfixes-unstable.  We can still make changes if needed.

I understand what Markus is suggesting is adding another goto label to make
the flow cleaner.  Because this is a hotfix that aims to be also applied to
stable kernels, I think the change is better to be as simple as possible.
Adding another goto label could make it better, but I'm concerned if it will
make porting difficult.

IMHO, it is better to do that as a followup cleanup, rather than make change
into the hotfix.  Let me know if this change is somewhat critical and I'm
missing that.

> 
> Are there still development interests for the application of a better goto chain?

Sure, if it makes it better, why not? :)


Thanks,
SJ

[...]
