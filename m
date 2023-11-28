Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57613FE3
	for <damon@lists.linux.dev>; Tue, 28 Nov 2023 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eONxP+ZS"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6cbda959062so4495146b3a.1
        for <damon@lists.linux.dev>; Mon, 27 Nov 2023 23:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701156889; x=1701761689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8tC1vo962immBLHWFedYDSlvhqp+GdE0dvr3eRBBUwo=;
        b=eONxP+ZSFyBXUbCsG+iAes48PSeo+TcDoSOk9vMOhjTeEDxGxEjRn2V5XrreSvxNEg
         2OnTM4U4SMcioht5cbULsY1rp5X+fCvyovZV5PhBlCdvr/2l+K95KV9GCQaRrtcxMMjJ
         JN/1smzR3dJQCuSviEJx7EOVkB3hGfNZBePFuCuHL6cPdl7X7zlx1oABRvxBlJySlnMH
         LDnX0iuDjT1qlA2wgxn57AtA/OtjExIJUYOasbPuI+7Q3n2vFWh8tvaQZdQ53IDL3fpy
         an9r/rKJUuZWDdby3jq2/VKjDoRNhsxqn6kV3xR1Idv2FPsywo7YRv8qEqnVwlKpEYya
         UUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156889; x=1701761689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tC1vo962immBLHWFedYDSlvhqp+GdE0dvr3eRBBUwo=;
        b=MoN9e9nLYtJ84Pnwu8yI8pVZVkowk7tqnIb7XYlLrFKOiBetKATeSol000KMyjx4bA
         FrxV0vgw65eDWrSzZniZcoCo+wmATZ6MsN389C6MUoY++0XzS+uc4ghOZUHNaOE5t7XR
         eK9KJUICBwD7NdZEkUQ7D/0z6WaV5J0McDGDdpvpN3jgxN/Dbqr2NkZaxNLeWVFejDRM
         ISTXX9jXg/+qDfKS30cmf2Y1kG/UbeaCrywnVwXoDhSV3ksvAZRhrKjwQy6spUJc3r56
         6T855ohrRxHbZ+uWNFul6rJ5YFLLQW1mqNqc2xpJlV7nBi51bID3pHvoKhr0hMurCVit
         6VUA==
X-Gm-Message-State: AOJu0YwYe95H2Sy18w3Vy2Yw1/8b8IDHCugy/d83F1UiEaz5j90NTD1m
	IHQR1LbsDGWkCgbjnkBdquQ=
X-Google-Smtp-Source: AGHT+IEwSoEUaKAMjeNT/B4UJ5bMwZdWDAfLciF7L1mX1p1kKd8ibEh0049/OWwsh4tfQl6RWFuIfQ==
X-Received: by 2002:a05:6a00:21d2:b0:68e:3772:4e40 with SMTP id t18-20020a056a0021d200b0068e37724e40mr14373197pfj.3.1701156888736;
        Mon, 27 Nov 2023 23:34:48 -0800 (PST)
Received: from cuiyangpei.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cb4fa1174dsm8331333pfn.124.2023.11.27.23.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:34:48 -0800 (PST)
From: cuiyangpei <cuiyangpei@gmail.com>
X-Google-Original-From: cuiyangpei <cuiyangpei@xiaomi.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: cuiyangpei <cuiyangpei@xiaomi.com>
Subject: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Tue, 28 Nov 2023 15:34:39 +0800
Message-ID: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user space users can control DAMON and get the monitoring results
via implements 'recording' feature in 'damon-sysfs'.  The feature
can be used via 'record' and 'state' file in the '<sysfs>/kernel/mm/
damon/admin/kdamonds/N/' directory.

The file allows users to record monitored access patterns in a text
file. Firstly, users set the size of the buffer and the path of the
result file by writing to the ``record`` file. Then the recorded
results are first written in an in-memory buffer and flushed the
recorded results to a file in batch by writing 'record' to the
``state`` file.

For example, below commands set the buffer to be 4 KiB and the result
to be saved in ``/damon.txt``. ::

    # cd <sysfs>/kernel/mm/damon/admin/kdamonds/N
    # echo "4096 /damon.txt" > record
    # echo "record" > state

Signed-off-by: cuiyangpei <cuiyangpei@xiaomi.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         |  20 +-
 include/linux/damon.h                         |  11 +
 mm/damon/sysfs.c                              | 282 ++++++++++++++++++
 3 files changed, 307 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b35649a46a2f..819534dcfb6c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -25,15 +25,23 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		stops, respectively.  Reading the file returns the keywords
 		based on the current status.  Writing 'commit' to this file
 		makes the kdamond reads the user inputs in the sysfs files
-		except 'state' again.  Writing 'update_schemes_stats' to the
-		file updates contents of schemes stats files of the kdamond.
-		Writing 'update_schemes_tried_regions' to the file updates
-		contents of 'tried_regions' directory of every scheme directory
-		of this kdamond.  Writing 'update_schemes_tried_bytes' to the
-		file updates only '.../tried_regions/total_bytes' files of this
+		except 'state' again.  Writing 'record' to this file makes the
+		kdamond saves the monitoring results to file specified by the
+		/record file. Writing 'update_schemes_stats'to the file updates
+		contents of schemes stats files of the kdamond. Writing
+		'update_schemes_tried_regions' to the file updates contents of
+		'tried_regions' directory of every scheme directory of this
+		kdamond.  Writing 'update_schemes_tried_bytes' to the file
+		updates only '.../tried_regions/total_bytes' files of this
 		kdamond.  Writing 'clear_schemes_tried_regions' to the file
 		removes contents of the 'tried_regions' directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/record
+Date:		Nov 2023
+Contact:	Ping Xiong <xiongping1@xiaomi.com>
+Description:	Writing a string '4096 /damon.txt' to this file makes the
+		user to record monitored access patterns in a text file.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
diff --git a/include/linux/damon.h b/include/linux/damon.h
index ab2f17d9926b..6495513cc6de 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -19,6 +19,17 @@
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
+#define MIN_RECORD_BUFFER_LEN	1024
+#define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
+#define MAX_RFILE_PATH_LEN	256
+
+struct sysfs_recorder {
+	unsigned char *rbuf;
+	unsigned int rbuf_len;
+	unsigned int rbuf_offset;
+	char *rfile_path;
+};
+
 /* Get a random number in [l, r) */
 static inline unsigned long damon_rand(unsigned long l, unsigned long r)
 {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e27846708b5a..7a7d41e609e3 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -994,6 +994,8 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_OFF,
 	/* @DAMON_SYSFS_CMD_COMMIT: Update kdamond inputs. */
 	DAMON_SYSFS_CMD_COMMIT,
+	/* @DAMON_SYSFS_CMD_RECORD: Save the monitoring results to file. */
+	DAMON_SYSFS_CMD_RECORD,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
 	 * files.
@@ -1025,6 +1027,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"on",
 	"off",
 	"commit",
+	"record",
 	"update_schemes_stats",
 	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
@@ -1349,6 +1352,160 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 			kdamond->contexts->contexts_arr[0]);
 }
 
+/*
+ * Flush the content in the result buffer to the result file
+ */
+static int sysfs_flush_rbuffer(struct sysfs_recorder *rec)
+{
+	ssize_t sz;
+	loff_t pos = 0;
+	struct file *rfile;
+
+	if (!rec->rbuf_offset)
+		return 0;
+
+	rfile = filp_open(rec->rfile_path,
+			O_CREAT | O_RDWR | O_APPEND | O_LARGEFILE, 0644);
+	if (IS_ERR(rfile)) {
+		pr_err("Cannot open the result file %s\n",
+				rec->rfile_path);
+		return PTR_ERR(rfile);
+	}
+
+	while (rec->rbuf_offset) {
+		sz = kernel_write(rfile, rec->rbuf, rec->rbuf_offset, &pos);
+		if (sz < 0) {
+			filp_close(rfile, NULL);
+			return sz;
+		}
+		rec->rbuf_offset -= sz;
+	}
+	filp_close(rfile, NULL);
+
+	return 0;
+}
+
+/*
+ * Write a data into the result buffer
+ */
+static void sysfs_write_rbuf(struct damon_ctx *ctx, char *data, int size)
+{
+	struct sysfs_recorder *rec = ctx->callback.private;
+
+	if (!rec->rbuf_len || !rec->rbuf || !rec->rfile_path)
+		return;
+	if (rec->rbuf_offset + size > rec->rbuf_len)
+		sysfs_flush_rbuffer(ctx->callback.private);
+	if (rec->rbuf_offset + size > rec->rbuf_len) {
+		pr_warn("%s: flush failed, or wrong size given(%u, %d)\n",
+				__func__, rec->rbuf_offset, size);
+		return;
+	}
+
+	memcpy(&rec->rbuf[rec->rbuf_offset], data, size);
+	rec->rbuf_offset += size;
+}
+
+static unsigned int nr_damon_targets(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	unsigned int nr_targets = 0;
+	int count = 0;
+
+	damon_for_each_target(t, ctx) {
+		count++;
+		nr_targets++;
+	}
+
+	return nr_targets;
+}
+
+/*
+ * Store the aggregated monitoring results to the result buffer
+ *
+ * The format for the result buffer is as below:
+ *
+ *   <time> <number of targets>
+ *
+ *   target info: <pid> <number of regions>
+ *   region info: <start address> <region size> <nr_accesses>
+ */
+static int damon_flush_aggregation(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct timespec64 now;
+	struct task_struct *tsk;
+	int tsk_pid = -1;
+	unsigned int nr = 0;
+	char buf[128];
+	int rc = 0;
+
+	memset(buf, 0, sizeof(buf));
+	ktime_get_coarse_ts64(&now);
+	nr = nr_damon_targets(c);
+	rc = scnprintf(buf, sizeof(buf), "time: %lld.%09ld, nr: %u\n",
+			(long long)now.tv_sec, now.tv_nsec, nr);
+	if (!rc)
+		return -ENOMEM;
+
+	sysfs_write_rbuf(c, buf, rc);
+	memset(buf, 0, sizeof(buf));
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+
+		tsk = get_pid_task(t->pid, PIDTYPE_PID);
+		tsk_pid = tsk->pid;
+		nr = damon_nr_regions(t);
+		rc = scnprintf(buf, sizeof(buf), "pid: %d, nr: %u\n", tsk_pid, nr);
+		if (!rc)
+			return -ENOMEM;
+
+		sysfs_write_rbuf(c, buf, rc);
+		memset(buf, 0, sizeof(buf));
+
+		damon_for_each_region(r, t) {
+
+			rc = scnprintf(buf, sizeof(buf), "%lu, %lu, %d\n",
+					r->ar.start, r->ar.end - r->ar.start, r->nr_accesses);
+			if (!rc)
+				return -ENOMEM;
+
+			sysfs_write_rbuf(c, buf, rc);
+			memset(buf, 0, sizeof(buf));
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * damon_sysfs_record() - Save the monitoring results to file.
+ * @kdamond:	The kobject wrapper for the associated kdamond.
+ *
+ * If the sysfs input is wrong, the kdamond will be terminated.
+ */
+static int damon_sysfs_record(struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct sysfs_recorder *rec = ctx->callback.private;
+	int err = 0;
+
+	if (!damon_sysfs_kdamond_running(kdamond))
+		return -EINVAL;
+	/* TODO: Support multiple contexts per kdamond */
+	if (kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	err = damon_flush_aggregation(ctx);
+	if (!err) {
+		if (rec->rbuf_offset)
+			err = sysfs_flush_rbuffer(rec);
+	}
+
+	return err;
+}
+
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
  * @c:		The DAMON context of the callback.
@@ -1371,6 +1528,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 	if (!kdamond || kdamond->damon_ctx != c)
 		goto out;
 	switch (damon_sysfs_cmd_request.cmd) {
+	case DAMON_SYSFS_CMD_RECORD:
+		err = damon_sysfs_record(kdamond);
+		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
 		err = damon_sysfs_upd_schemes_stats(kdamond);
 		break;
@@ -1433,6 +1593,65 @@ static int damon_sysfs_after_aggregation(struct damon_ctx *c)
 	return damon_sysfs_cmd_request_callback(c, true);
 }
 
+/*
+ * sysfs_set_recording() - Set attributes for the recording.
+ * @ctx:	target kdamond context
+ * @rbuf_len:	length of the result buffer
+ * @rfile_path:	path to the monitor result files
+ *
+ * Setting 'rbuf_len' 0 disables recording.
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int sysfs_set_recording(struct damon_ctx *ctx,
+			unsigned int rbuf_len, char *rfile_path)
+{
+	struct sysfs_recorder *recorder;
+	size_t rfile_path_len;
+
+	if (rbuf_len && (rbuf_len > MAX_RECORD_BUFFER_LEN ||
+			rbuf_len < MIN_RECORD_BUFFER_LEN)) {
+		pr_err("result buffer size (%u) is out of [%d,%d]\n",
+				rbuf_len, MIN_RECORD_BUFFER_LEN,
+				MAX_RECORD_BUFFER_LEN);
+		return -EINVAL;
+	}
+	rfile_path_len = strnlen(rfile_path, MAX_RFILE_PATH_LEN);
+	if (rfile_path_len >= MAX_RFILE_PATH_LEN) {
+		pr_err("too long (>%d) result file path %s\n",
+				MAX_RFILE_PATH_LEN, rfile_path);
+		return -EINVAL;
+	}
+
+	recorder = ctx->callback.private;
+	if (!recorder) {
+		recorder = kzalloc(sizeof(*recorder), GFP_KERNEL);
+		if (!recorder)
+			return -ENOMEM;
+		ctx->callback.private = recorder;
+	}
+
+	recorder->rbuf_len = rbuf_len;
+	kfree(recorder->rbuf);
+	recorder->rbuf = NULL;
+	kfree(recorder->rfile_path);
+	recorder->rfile_path = NULL;
+
+	if (rbuf_len) {
+		recorder->rbuf = kvmalloc(rbuf_len, GFP_KERNEL);
+		if (!recorder->rbuf)
+			return -ENOMEM;
+	}
+	recorder->rfile_path = kmalloc(rfile_path_len + 1, GFP_KERNEL);
+	if (!recorder->rfile_path)
+		return -ENOMEM;
+	strscpy(recorder->rfile_path, rfile_path, rfile_path_len + 1);
+
+	return 0;
+}
+
 static struct damon_ctx *damon_sysfs_build_ctx(
 		struct damon_sysfs_context *sys_ctx)
 {
@@ -1442,6 +1661,12 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
+	err = sysfs_set_recording(ctx, 0, "none");
+	if (err) {
+		damon_destroy_ctx(ctx);
+		return ERR_PTR(err);
+	}
+
 	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
 	if (err) {
 		damon_destroy_ctx(ctx);
@@ -1599,6 +1824,59 @@ static ssize_t pid_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", pid);
 }
 
+static ssize_t record_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx;
+	struct sysfs_recorder *rec;
+	int len = 0;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	ctx = kdamond->damon_ctx;
+	if (!ctx)
+		goto out;
+	rec = ctx->callback.private;
+	len = sysfs_emit(buf, "%u %s\n", rec->rbuf_len, rec->rfile_path);
+
+out:
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
+}
+
+static ssize_t record_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx;
+	unsigned int rbuf_len;
+	char rfile_path[MAX_RFILE_PATH_LEN];
+	ssize_t ret = count;
+	int err;
+
+	if (sscanf(buf, "%10u %128s", &rbuf_len, rfile_path) != 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	ctx = kdamond->damon_ctx;
+	if (!ctx)
+		goto unlock_out;
+
+	err = sysfs_set_recording(ctx, rbuf_len, rfile_path);
+	if (err)
+		ret = err;
+unlock_out:
+	mutex_unlock(&damon_sysfs_lock);
+out:
+	return ret;
+}
+
 static void damon_sysfs_kdamond_release(struct kobject *kobj)
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
@@ -1615,9 +1893,13 @@ static struct kobj_attribute damon_sysfs_kdamond_state_attr =
 static struct kobj_attribute damon_sysfs_kdamond_pid_attr =
 		__ATTR_RO_MODE(pid, 0400);
 
+static struct kobj_attribute damon_sysfs_kdamond_record_attr =
+		__ATTR_RW_MODE(record, 0600);
+
 static struct attribute *damon_sysfs_kdamond_attrs[] = {
 	&damon_sysfs_kdamond_state_attr.attr,
 	&damon_sysfs_kdamond_pid_attr.attr,
+	&damon_sysfs_kdamond_record_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_kdamond);
-- 
2.43.0

