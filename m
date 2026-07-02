Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0433BBB9;
	Thu,  2 Jul 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010380; cv=none; b=rwt4LeXYpWi3U47Y9RxLRhbs5OwB5Xo2bDiGL1ZipuitI8gFJyrAdJgXXCi47GAZ+Mj/TAEz7C45ULlg5g8wnxJnw/sQRyTm8ktnR9yQNiCRfyn+s9fkG+XEsTVgL0KUHWZA24w8bdA3MvNLOQ9IwUy4nhdzmkxbl6gehOdkuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010380; c=relaxed/simple;
	bh=Mc+f9/wHAywQ867nU+MFi7RsxZ70GMTzp+iqziWSrNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8Gr+N+THfU340dvDAZKpIgxZ59LfORZwFg9uiksZS2rTBi8Zy+Y6kAkfQIN014RY3N7eUj1OnFRglCC/kYr2dfkB1zQZWWctMVo8js52whWwmhw/Vm1sz7M8fHPE6uOjvPWSxq9veUeocyw/SC//lTWZ5Fst7VRu6YiSyyBlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3CntqjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3CntqjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D38B1F00A3A;
	Thu,  2 Jul 2026 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010379;
	bh=3U4Pu3SkeAaU0OMoDMoDHcyux0m0zke1PXLSBG8YI/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j3CntqjPqMtofrH8ye6WRIp8cdPg5aZaX9MVSC6KQRKwqC+/r73jfrGirDW4Ov5BX
	 MSbpLqCHbK1auotjClbW6NpXha6JiebYg0gyNHW1WpvICHkGNTLdJZECgnTyIi4ZPm
	 Kz9yaVRjXzK9gVbXKz0NNVSqBEYYJ23q1YDWrxkHAURwizXXttOohahJD4ot1rAWYo
	 utSCigkNJ5Icp7wy988bWL6IZoFhsdnk3Dvov2Z5LVfClibCqN7WblbmbwmzbmfjKH
	 JkAmC9DXGvQEDflygr9xGJOG28wgaA9Oc1ext1jtIu/LwBf36WjSb2twB1I8oieZXG
	 HfM0taTXs0qaw==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	kunwu.chan@gmail.com
Subject: Re: [RESEND RFC PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Thu,  2 Jul 2026 09:39:05 -0700
Message-ID: <20260702163905.86497-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702095227.75866-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Jul 2026 17:52:22 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Resend of v2 with the RFC tag restored (v1 was RFC PATCH, so v2 should
> be RFC PATCH v2).

Somehow you sent this twice.  Maybe your email setup issue?  You also replied
same message twice to my previous comment.  Anyway, I will review the later
posted one: https://lore.kernel.org/20260702094633.75658-1-lianux.mm@gmail.com


Thanks,
SJ

[...]
