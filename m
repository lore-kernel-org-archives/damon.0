Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8343261399;
	Fri,  4 Jul 2025 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653448; cv=none; b=GWjXTCX8Sh84vec6d8maWKuXNnWukLY+VUCpeDoSP5/SF33V5iX9EzQoxB7PXEjKByhWS4WgF06E3JykxGxWIsFRK2ttUPtqo4K6OPfoGXzvwCcchGlb10cP5VIGJska8H9FaLdNiupUt/SmMGU9NAdSH0EGEBxYNL4m1a5RQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653448; c=relaxed/simple;
	bh=x/a97G6tGt7l3YWx8tm//SOtg12sNF3g8piy675aVjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hy5wrzGlqKeL1cpkG8tXxzfqa2NQvrsIt1hAc5NE2tYXgn83x1yVu75TNulkkQdGYzSICmmuM8sDrPy5QMPOmxVIqh1/Abi4Y2w2p/KkYM1PaZjjpYzqzCx7A2lUQA+4RGKH7xkcZAqeQ7uFx+PtV9zhuzNcS2O3Zz8W4/0keVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Irx2uYzK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Irx2uYzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E84BC4CEE3;
	Fri,  4 Jul 2025 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751653448;
	bh=x/a97G6tGt7l3YWx8tm//SOtg12sNF3g8piy675aVjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Irx2uYzKkDetJQaPWejxHZb3Kx6pybEHKZpto6Bp6Wtk2rZxqF6ZwYJgcs6XPicVF
	 UEHo6vbLVAuOZ3UlvKlupEn3DAPIwGnjqRzZIsIxKYIyagS/LP61nUUk5/1xRJtQzf
	 atlFouHudW1TdueywtaePPfpp2TmtNUNnDd/eidQBzn6zPdK8MfiyqhdGtpvtfZqSI
	 BevBXYn9Oi40Lh78rnkP8IZbyNnXduKDK6ycbUp208EKi1bBoYSV5FSJNbXlajkvoa
	 6NgTiHrQJFBTXtqMqVlP7gmF4vV3eHB6uimyaBWoQrlN3ZoF5VUSc3NR3wD+E5O0l2
	 qhgsKIqRG2eSA==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH v2] samples/damon: support automatic node address detection
Date: Fri,  4 Jul 2025 11:24:05 -0700
Message-Id: <20250704182405.51346-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704070600.1786-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  4 Jul 2025 16:05:59 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> Hello Seongjae,
> 
> On Thu,  3 Jul 2025 09:52:37 -0700 SeongJae Park <sj@kernel.org> wrote:
> > Hello Yunjeong,
> > 
> > On Thu,  3 Jul 2025 16:44:22 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > 
> > > This patch adds a new knob `detect_node_addresses`, which determines
> > > whether the physical address range is set manually using the existing
> > > knobs or automatically by the mtier module. When `detect_node_addresses`
> > > set to 'Y', mtier automatically converts node0 and node1 to their
> > > physical addresses. If set to 'N', it uses the existing
> > > 'node#_start_addr' and 'node#_end_addr' to define regions as before.
> > 
> > Thank you for this patch!
> > 
> > > 
> > > Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> > > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > 
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > 
> > > ---
> > 
> > From next time, please consider adding a summary of what changes have made from
> > the previous version here, like suggested[1] on the documentation.
> 
> Ok, I'll add it next time, thanks:)
> One concern I have about this patch is the requirement to set
> 'detect_node_addresses=Y' before setting 'enable=Y'. Not following
> this order causes an error, which makes it difficult for users to use
> the module.

That's same to existing address parameters, and similar to existing DAMON user
interfaces.  Parameters are applied when starting DAMON.  Parameters can be
updated while DAMON is running, but it requires explicit "commit" action for
updating those at once.

DAMON sample modules don't support the runtime commit feature, though.  I think
it is not a bad tradeoff for simplicity of the code, given the purpose of
sample modules.

> So, how about removing 'detect_node_address'? Instead, we
> could convert node0,1 to physical address automatically by default, and use
> existing 'node#_*_addr' values only when those files are explicitly set.

This would make old usage broken.  Since this is a sample module, I think that
could be justified if there is a very good reason.  But I don't think we have a
very good reason here.  So I suggest not to do that.


Thanks,
SJ

[...]
