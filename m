Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F8318ED9
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036853; cv=none; b=guiZd1A8tR+I62mimUoqg5VUsp1gOgM26SJyGeOra5RbPnJ1bqJija3pyWH9YkVNh+0mCfPqaANv+XL/uICmM0cYWZXd3sUFGWCpmzin/+NZ3MYzWRG4mpRefju7ctb/tDy+48rHlXjIJbeCr+LQsrgrfyaBrQoJop6d5xwmok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036853; c=relaxed/simple;
	bh=ZBwLsxyQXTfB+te7jqAdorWffsH/iaEzz5lDCdlJyuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWGwSkvYE++teYSPKaM58wA+UfByG1jQlhJgXJr3iJdS+OHUrQssMyRsIe93I+/9tQVVXIiz52ER105yRXrhZCqa+kP59nCY7yLAK+RCftvppAjgWf8dmN9HY7zYsqP8B9R+Pkld8U5M7tQTfMpv1XdAGmG1r6fS3K+pUWcdFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2D61F000E9;
	Tue, 18 Aug 2026 07:07:22 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/7] docs/zh_CN: update DAMON LRU sort translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818070358.455768-8-doehyunbaek@gmail.com>
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
 <20260818070358.455768-8-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:07:21 +0000
Message-Id: <20260818070722.4C2D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update the Chinese translation of .../admin-guide/mm/damon/lru_sort.rst.
>=20
> Update the translation through commit c9380cdd949d
> ("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").
>=20
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818070358.4557=
68-1-doehyunbaek@gmail.com?part=3D7

